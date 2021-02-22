import 'package:flutter_application_1/models/api_models.dart';

abstract class BookService {
  Future<List<Book>> getBooks(String searchString);

  Future<Book> getBook(String isbn13);

  Future<void> addBook(Book book);

  Future<void> removeBook(Book book);
}
