import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/api_models.dart';

import 'book_service.dart';

class LocalBookService implements BookService {
  @override
  Future<List<Book>> getBooks() async {
    try {
      // Read the file.
      String data = await rootBundle.loadString('assets/BooksList.txt');
      dynamic jsonBooks = jsonDecode(data);
      List<Book> books = List();

      for (dynamic book in jsonBooks['books']) {
        books.add(Book.fromJson(book));
      }
      return books;
    } catch (e) {
      // If encountering an error, return [].
      return [];
    }
  }

  @override
  Future<Book> getBook(String isbn13) async {
    try {
      // Read the file.
      String data = await rootBundle.loadString('assets/id/$isbn13.txt');

      dynamic jsonBook = jsonDecode(data);
      Book book = Book.fromJson(jsonBook);
      return book;
    } catch (e) {
      // If encountering an error, return null.
      return null;
    }
  }
}
