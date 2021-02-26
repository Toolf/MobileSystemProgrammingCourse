# Lab 7

Виконав: <br/>
Студент групи: ІО-81 <br/>
ЗК: ІО-8125 <br/>
Смірнов Назар <br/>

## Варіант №2

1. Візьміть за основу проєкт із лабораторної роботи 6.
2. Додайте функціональність збереження завантажених даних з мережі у сховище.
3. Сховище даних визначте за варіантом, де варіант = (номер залікової книжки mod 2) + 1:

| Варіант 1            | Варіант 2         |
| -------------------- | ----------------- |
| Технологія Core Data | База даних SQLite |

4. Всі дані, які завантажуються з мережі, необхідно зберегти у сховище.
5. Модифікуйте механізм завантаження даних для відображення у таблиці сутностей та колекції зображень наступним чином:
   a) спочатку виконується запит за відповідною URL-адресою, як це реалізовано в лабораторній роботі 6;
   b) якщо дані успішно отримані, то вони зберігаються у сховище та використовуються для відображення;
   c) якщо дані з мережі не отримано або виникла якась помилка (код статусу відповіді не 200, відсутнє Інтернет з’єднання, тощо), то необхідно спробувати отримані дані для відповідного запиту зі сховища:
   i. якщо дані зі сховища успішно отримані, то вони використовуються для відображення;
   ii. якщо дані у сховищі відсутні, то необхідно вивести повідомлення, що неможливо отримати дані для заданого запиту.
6. Додайте кешування зображень, які завантажуються, так що, якщо потрібно повторно відобразити зображення, то воно не завантажується з мережі, а отримується з кешу зображень.
7. Наприклад:
   a) користувач вперше запускає додаток з наявним Інтернет з’єднанням;
   b) на екрані списку сутностей користувач вводить запит у поле пошуку;
   c) дані успішно завантажуються з мережі, зберігаються у сховище та відображаються в таблиці;
   d) користувач видаляє запит з поля пошуку;
   e) відображається порожній список;
   f) користувач вимикає Інтернет з’єднання на пристрої;
   g) користувач вводить запит з кроку b у поле пошуку;
   h) при завантаженні даних з мережі виникає помилка, оскільки відсутнє Інтернет з’єднання;
   i) відбувається спроба отримати дані зі сховища;
   j) оскільки для запиту з кроку b у сховищі є дані (крок c), то вони відображаються в таблиці;
   k) користувач вводить інший запит у поле пошуку;
   l) при завантаженні даних з мережі виникає помилка, оскільки відсутнє Інтернет з’єднання;
   m) відбувається спроба отримати дані зі сховища;
   n) оскільки для запиту з кроку k у сховищі дані відсутні, то виводиться повідомлення, що неможливо отримати дані для заданого запиту;
   o) відповідна поведінка повинна бути реалізована для колекції зображень:
   i. дані зберігаються у сховище;
   ii. зображення зберігаються у сховище або на диск.
8. Переконайтеся, що можете запустити проєкт, та що все працює коректно.
9. Закомітьте та відправте ваш проєкт до будь-якої системи контролю версій.
10. Підготуйте протокол за шаблоном.
11. Надішліть виконане завдання через Google Classroom - додайте посилання до вашого проєкту та протокол.

## приклад роботи додатка

Приклад роботи для списку книг
(відео в .mp4 лижить в readme_images)
![](readme_images/video2.gif)
<br/>
Приклад роботи для галереї
(відео в .mp4 лижить в readme_images)
![](readme_images/video1.gif)

## Лістинг коду

```dart {.line-numbers}
// databases/db_provider.dart

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
```

```dart {.line_numbers}
// services/book_service_decorator.dart

import 'package:flutter_application_1/databases/db_provider.dart';
import 'package:flutter_application_1/models/api_models.dart';
import 'package:flutter_application_1/services/book_service.dart';
import 'package:flutter_application_1/services/exceptions.dart';

abstract class BookServiceDecorator extends BookService {
  // ignore: unused_element
  BookService get bookService;
}

class SqliteBookServiceDecorator implements BookServiceDecorator {
  final BookService _bookService;

  SqliteBookServiceDecorator(this._bookService);

  @override
  BookService get bookService => _bookService;

  @override
  Future<void> addBook(Book book) async {
    await bookService.addBook(book);
  }

  @override
  Future<Book> getBook(String isbn13) async {
    try {
      final book = await bookService.getBook(isbn13);
      DBProvider.db.newBook(book);
      return book;
    } on NetworkException {
      final res = await DBProvider.db.getBook(isbn13);
      if (res == null) {
        throw NotFoundException();
      }
      return res;
    }
  }

  @override
  Future<List<Book>> getBooks(String searchString) async {
    try {
      final books = await bookService.getBooks(searchString);
      DBProvider.db.newBooks(books);
      return books;
    } on NetworkException {
      return DBProvider.db.getBooks(searchString);
    }
  }

  @override
  Future<void> removeBook(Book book) async {
    await bookService.removeBook(book);
  }
}
```

```dart {.line_numbers}
// services/gallery_service_decorator.dart

import 'dart:typed_data';

import 'package:flutter_application_1/databases/db_provider.dart';
import 'package:flutter_application_1/services/exceptions.dart';
import 'package:flutter_application_1/services/gallery_service.dart';

abstract class GallaryServiceDecorator extends GalleryService {
  GalleryService get galleryService;
}

class SqliteGalleryServiceDecorator implements GallaryServiceDecorator {
  final DBProvider db = DBProvider.db;
  final GalleryService _galleryService;

  SqliteGalleryServiceDecorator(this._galleryService);

  @override
  GalleryService get galleryService => _galleryService;

  @override
  Future<Uint8List> getImage(String url) async {
    try {
      var res = await db.getImage(url);
      if (res != null) {
        return res;
      }
      final image = await galleryService.getImage(url);
      db.newImage(url, image);
      return image;
    } on NetworkException {
      return await db.getImage(url);
    }
  }

  @override
  Future<List<String>> getImages() async {
    try {
      final urls = await galleryService.getImages();
      await db.newImages(urls);
      return urls;
    } on NetworkException {
      return db.getImages();
    }
  }
}
```

## Висновок

Вданій лабораторній роботі боло добавнело локальну базу даних, в яку зберігаються картинки та інформація про книжки. Виникнули проблеми при відключені wifi в емулятора всерівно працював інтернет, прийшлось відключати wifi на машинині на якій запускався емулятор. Крім даної проблеми більше ніякий затруднень не виникло.
