import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Future<Widget> _getImage(String path) async {
    if (path == null) {
      return SizedBox.shrink();
    }

    try {
      await rootBundle.load(path);
      return Image.asset(path);
    } catch (_) {
      return SizedBox.shrink();
    }
  }

  Future<Widget> buildItem(Book book) async {
    Widget image;
    if (book.image != "") {
      image = await _getImage('assets/Images/${book.image}');
    } else {
      image = await _getImage(null); // return default image
    }
    return ListTile(
      isThreeLine: true,
      title: Text(book.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(book.subtitle),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(book.price),
          ),
        ],
      ),
      leading: Container(
        child: image,
        width: 50,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Widget>>(
        future: Future(() async {
          List<Book> books = await widget.bookService.getBooks();
          List<Widget> bookWidgets = List();
          for (Book book in books) {
            bookWidgets.add(await buildItem(book));
          }
          return bookWidgets;
        }),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<Widget> books = snapshot.data;
          return ListView.separated(
            itemCount: books.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return books[index];
            },
          );
        },
      ),
    );
  }
}
