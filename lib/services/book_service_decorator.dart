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
