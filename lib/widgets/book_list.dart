import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import '../pages/book_add.dart';
import '../pages/book_details.dart';
import '../services/book_service.dart';
import '../services/local_book_service.dart';
import '../models/api_models.dart';

class BookList extends StatefulWidget {
  final BookService bookService = LocalBookService();

  BookList({Key key}) : super(key: key);

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<Book> books = List();
  List<Widget> bookWidgets = List();
  List<Widget> showWidgets = List();
  String searchLine = "";

  @override
  void initState() {
    super.initState();
    widget.bookService.getBooks().then((List<Book> books) async {
      List<Widget> bookWidgets = List();
      for (Book book in books) {
        bookWidgets.add(await _buildItem(book));
      }
      setState(() {
        this.books = books;
        this.bookWidgets = bookWidgets;
        this.showWidgets = bookWidgets.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: TextField(
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              labelText: "Search",
              labelStyle: TextStyle(color: Colors.white),
            ),
            onChanged: (value) {
              setState(() {
                searchLine = value;
                showWidgets = bookWidgets
                    .where((w) =>
                        books[bookWidgets.indexOf(w)].title.contains(value))
                    .toList();
              });
            },
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(_bookAddPageRoute());
              },
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: showWidgets.length != 0
                ? ListView.builder(
                    itemCount: showWidgets.length,
                    itemBuilder: (context, index) => showWidgets[index],
                  )
                : Center(
                    child: Text("No items found"),
                  ),
          ),
        ],
      ),
    );
  }

  Future<Widget> _buildItem(Book book) async {
    Widget image;
    if (book.image == null) {
      image = SizedBox.shrink(); // return default image
    } else {
      image = book.image;
    }
    return Slidable(
      key: Key(book.title),
      actionPane: SlidableScrollActionPane(),
      child: Container(
        color: Colors.white,
        child: ListTile(
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
          onTap: () async {
            Book bookMore = await widget.bookService.getBook(book.isbn13);
            if (bookMore != null) {
              Navigator.of(context).push(_createRoute(bookMore));
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Text("Not found resurce")));
            }
          },
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            _removeBook(book);
          },
        ),
      ],
    );
  }

  void _removeBook(book) {
    var index = books.indexOf(book);

    setState(() {
      if (showWidgets.contains(bookWidgets[index])) {
        showWidgets.removeAt(showWidgets.indexOf(bookWidgets[index]));
      }
      books.removeAt(index);
      bookWidgets.removeAt(index);
    });
  }

  void _addBook(Book book) async {
    Widget w = await _buildItem(book);

    setState(() {
      books.add(book);
      bookWidgets.add(w);
      if (book.title.contains(searchLine)) {
        showWidgets.add(w);
      }
    });
  }

  Route _createRoute(Book book) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          BookPage(book: book),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _bookAddPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return BookAdd(
          onValid: (book) => _addBook(book),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
