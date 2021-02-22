import 'package:flutter_application_1/models/api_models.dart';
import 'package:flutter_application_1/services/book_service.dart';

class MockBookService implements BookService {
  final books = [
    Book(
      title: "Title1",
      image: "Image_01.png",
      isbn13: "",
      price: "\$15.33",
      subtitle: "subtitle1",
    ),
    Book(
      title: "Title2",
      image: "",
      isbn13: "8457",
      price: "Priceless",
      subtitle: "subtitle2",
    )
  ];

  @override
  Future<Book> getBook(String isbn13) {
    Book book_details = Book(
      title: "title",
      subtitle: "subtitle",
      price: "\$1",
      image: "Image_01.png",
      publisher: "publisher",
      authors: "authors",
      desc: "Desc",
      isbn13: isbn13,
      pages: "321",
      rating: "44",
      year: "2000",
    );
    for (Book book in books) {
      if (book.isbn13 == isbn13) {
        return Future.delayed(Duration(seconds: 2), () => book_details);
      }
    }
    return null;
  }

  @override
  Future<List<Book>> getBooks(String searchString) {
    return Future.delayed(
        Duration(seconds: 0),
        () =>
            books.where((book) => book.title.contains(searchString)).toList());
  }

  @override
  Future<void> addBook(Book book) async {
    books.add(book);
  }

  @override
  Future<void> removeBook(Book book) async {
    books.remove(book);
  }
}
