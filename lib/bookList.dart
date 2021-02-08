import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/book_service.dart';
import 'package:flutter_application_1/services/local_book_service.dart';

import 'models/api_models.dart';

class BookList extends StatefulWidget {
  final BookService bookService = LocalBookService();

  BookList({Key key}) : super(key: key);

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: widget.bookService.getBooks(),
        builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<Book> books = snapshot.data;
          return SingleChildScrollView(
            child: Table(
              columnWidths: {0: FractionColumnWidth(0.3)},
              children: books.map(
                (Book book) {
                  Widget image = book.image != null
                      ? Image.asset(
                          './assets/Images/${book.image}',
                        )
                      : Container();
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [image],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.title,
                            ),
                            Text(book.subtitle),
                            Text(book.isbn13),
                            Text(book.price),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ).toList(),
            ),
          );
        },
      ),
    );
  }
}
