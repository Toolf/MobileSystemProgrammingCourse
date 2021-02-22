import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_application_1/models/api_models.dart';
import 'package:flutter_application_1/services/book_service.dart';

class HttpBookService implements BookService {
  var url = 'https://api.itbook.store/1.0';
  @override
  Future<List<Book>> getBooks(String searchString) async {
    var response = await http.get('$url/search/$searchString');

    if (response.statusCode != 200) {
      return [];
    }

    dynamic body = jsonDecode(response.body);
    if (body['error'] != "0") {
      return [];
    }

    List<Book> books = List();
    for (dynamic jsonBook in body['books']) {
      books.add(Book.fromJson(jsonBook));
    }
    return books;
  }

  @override
  Future<Book> getBook(String isbn13) async {
    var response = await http.get('$url/books/$isbn13');
    if (response.statusCode != 200) {
      return null;
    }

    dynamic body = jsonDecode(response.body);
    if (body['error'] != "0") {
      return null;
    }

    return Book.fromJson(body);
  }

  @override
  Future<void> addBook(Book book) {
    return Future(() => print("Add book"));
  }

  @override
  Future<void> removeBook(Book book) {
    return Future(() => print("Remove book"));
  }
}
