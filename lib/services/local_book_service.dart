import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/api_models.dart';

import 'book_service.dart';

class LocalBookService implements BookService {
  @override
  Future<List<Book>> getBooks() async {
    try {
      // final file = await _localFile;

      // Read the file.
      String data = await rootBundle.loadString('assets/BooksList.txt');
      print(data);
      dynamic jsonBooks = jsonDecode(data);
      List<Book> books = List();

      for (dynamic book in jsonBooks['books']) {
        books.add(Book.fromJson(book));
      }
      print(data);
      return books;
    } catch (e) {
      print(e);
      // If encountering an error, return [].
      return [];
    }
  }
}
