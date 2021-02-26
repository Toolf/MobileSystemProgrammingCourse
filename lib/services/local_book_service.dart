import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/api_models.dart';

import 'book_service.dart';

class LocalBookService implements BookService {
  List<Book> books = List();
  LocalBookService() {
    init();
  }

  void init() async {
    try {
      String data = await rootBundle.loadString('assets/BooksList.txt');
      dynamic jsonBooks = jsonDecode(data);
      books = List();
      for (dynamic book in jsonBooks['books']) {
        if (book['image'] == "") {
          book['image'] = null;
        } else {
          book['image'] =
              (await rootBundle.load('assets/Images/${book['image']}'))
                  .buffer
                  .asUint8List();
        }
        books.add(Book.fromJson(book));
      }
    } catch (e) {
      books = [];
    }
  }

  @override
  Future<List<Book>> getBooks(String searchString) async {
    return Future(() =>
        books.where((book) => book.title.contains(searchString)).toList());
  }

  @override
  Future<Book> getBook(String isbn13) async {
    try {
      // Read the file.
      String data = await rootBundle.loadString('assets/id/$isbn13.txt');

      dynamic jsonBook = jsonDecode(data);
      if (jsonBook['image'] == "") {
        jsonBook['image'] = null;
      } else {
        jsonBook['image'] =
            (await rootBundle.load('assets/Images/${jsonBook['image']}'))
                .buffer
                .asUint8List();
      }
      Book book = Book.fromJson(jsonBook);
      return book;
    } catch (e) {
      // If encountering an error, return null.
      return null;
    }
  }

  @override
  Future<void> addBook(Book book) async {
    return Future(() => books.add(book));
  }

  @override
  Future<void> removeBook(Book book) {
    return Future(() {
      books.remove(book);
    });
  }
}
