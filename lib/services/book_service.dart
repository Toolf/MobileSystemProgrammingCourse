import 'package:flutter_application_1/models/api_models.dart';

abstract class BookService {
  Future<List<Book>> getBooks();

  Future<Book> getBook(String isbn13);
}
