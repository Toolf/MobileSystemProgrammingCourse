import 'package:flutter_application_1/models/api_models.dart';
import 'package:flutter_application_1/services/book_service.dart';

class MockBookService implements BookService {
  @override
  Future<List<Book>> getBooks() async {
    await Future<void>.delayed(Duration(seconds: 1));
    return [
      Book(
        title: "Title1",
        image: "",
        isbn13: "",
        price: "\$15.33\$",
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
  }
}
