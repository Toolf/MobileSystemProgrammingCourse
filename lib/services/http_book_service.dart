import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_application_1/services/exceptions.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_application_1/models/api_models.dart';
import 'package:flutter_application_1/services/book_service.dart';

class HttpBookService implements BookService {
  var url = 'https://api.itbook.store/1.0';
  @override
  Future<List<Book>> getBooks(String searchString) async {
    if (searchString == "") {
      return Future.delayed(Duration(seconds: 0), () => []);
    }
    var response = await http.get('$url/search/$searchString').timeout(
      Duration(seconds: 2),
      onTimeout: () {
        throw NetworkException();
      },
    );

    if (response.statusCode != 200) {
      throw NetworkException();
    }

    dynamic body = jsonDecode(response.body);
    if (body['error'] != "0") {
      throw NotFoundException();
    }

    List<Book> books = List();
    for (Map<String, dynamic> book in body['books']) {
      response = await http.get(book['image']);
      if (response.statusCode != 200) {
        book['image'] = null;
      } else {
        book['image'] = Uint8List.fromList(response.body.codeUnits);
      }

      books.add(Book.fromMap(book));
    }
    return books;
  }

  @override
  Future<Book> getBook(String isbn13) async {
    var response = await http.get('$url/books/$isbn13').timeout(
      Duration(seconds: 2),
      onTimeout: () {
        throw NetworkException();
      },
    );

    if (response.statusCode != 200) {
      throw NetworkException();
    }

    Map<String, dynamic> body = jsonDecode(response.body);
    if (body['error'] != "0") {
      throw NotFoundException();
    }

    response = await http.get(body['image']);
    if (response.statusCode != 200) {
      body['image'] = null;
    } else {
      body['image'] = Uint8List.fromList(response.body.codeUnits);
    }

    return Book.fromMap(body);
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
