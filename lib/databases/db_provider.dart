import 'dart:typed_data';

import 'package:flutter_application_1/models/api_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'super_db2.db'),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE books (
          isbn13 TEXT PRIMARY KEY,
          title TEXT,
          subtitle TEXT,
          price TEXT,
          image BLOB
        );
        ''');
        await db.execute('''
        CREATE TABLE books_details (
          isbn13 TEXT PRIMARY KEY,
          title TEXT,
          subtitle TEXT,
          price TEXT,
          image BLOB,
          publisher TEXT,
          pages TEXT,
          year TEXT,
          rating TEXT,
          desc TEXT,
          authors TEXT
        );
        ''');
        await db.execute('''
        CREATE TABLE gallery (
          url TEXT PRIMARY KEY,
          image BLOB
        );
        ''');
        await db.execute('''
        CREATE TABLE gallery_urls (
          url TEXT PRIMARY KEY
        );
        ''');
      },
      version: 1,
    );
  }

  newBook(Book newBook) async {
    final db = await database;

    var res = await db.insert(
      "books_details",
      newBook.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  newBooks(List<Book> books) async {
    if (books.length == 0) {
      return;
    }
    final db = await database;

    Batch batch = db.batch();
    for (Book book in books) {
      batch.insert(
        'books',
        {
          'isbn13': book.isbn13,
          'title': book.title,
          'subtitle': book.subtitle,
          'price': book.price,
          'image': book.image,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<Book> getBook(String isbn13) async {
    if (isbn13 == null) {
      return null;
    }
    final db = await database;
    var res = await db.query(
      "books_details",
      where: "isbn13 = ?",
      whereArgs: [isbn13],
    );
    return res.isNotEmpty ? Book.fromMap(res.first) : null;
  }

  Future<List<Book>> getBooks(String searchString) async {
    final db = await database;
    var res = await db.query("books", where: "title LIKE '%$searchString%'");
    return List.generate(res.length, (index) => Book.fromMap(res[index]));
  }

  newImage(String url, Uint8List image) async {
    final db = await database;
    await db.insert(
      'gallery',
      {'url': url, 'image': image},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  newImages(List<String> urls) async {
    final db = await database;
    Batch batch = db.batch();
    for (String url in urls) {
      batch.insert(
        'gallery_urls',
        {'url': url},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<Uint8List> getImage(String url) async {
    final db = await database;
    var res = await db.query(
      "gallery",
      where: "url = ?",
      whereArgs: [url],
    );
    return res.isNotEmpty ? res.first['image'] : null;
  }

  Future<List<String>> getImages() async {
    final db = await database;
    var res = await db.query('gallery_urls');
    return List.generate(res.length, (index) => res[index]['url']);
  }
}
