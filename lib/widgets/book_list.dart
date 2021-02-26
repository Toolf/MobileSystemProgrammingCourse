import 'package:flutter/material.dart';
import 'package:flutter_application_1/booklist/booklist_bloc.dart';
import 'package:flutter_application_1/helpers/debouncer.dart';
import 'package:flutter_application_1/services/book_service_decorator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import '../pages/book_add.dart';
import '../pages/book_details.dart';
import '../services/http_book_service.dart';
import '../models/api_models.dart';

class BookList extends StatefulWidget {
  // final BookService bookService = MockBookService();

  BookList({Key key}) : super(key: key);

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<Book> books;
  List<Widget> bookWidgets = List();
  String searchLine = "";

  final _debouncer = Debouncer(milliseconds: 500);

  final BooklistBloc _booklistBloc =
      BooklistBloc(SqliteBookServiceDecorator(HttpBookService()));

  @override
  void initState() {
    super.initState();
    _booklistBloc.add(GetBooklist(searchLine));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _booklistBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: SearchInputField(
              onChanged: (value) {
                _debouncer.run(() {
                  if (value != searchLine) {
                    setState(() {
                      searchLine = value;
                    });
                    // ignore: close_sinks
                    _updateBookList();
                  }
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
        body: BlocConsumer(
          cubit: _booklistBloc,
          listener: (BuildContext context, state) {
            if (state is BooklistError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          buildWhen: (previous, current) {
            if (current is BooklistDeleted) {
              setState(() {
                books.remove(current.book);
              });
              _booklistBloc.add(GetBooklist(searchLine));
              return false;
            } else if (current is BooklistAdded) {
              if (current.book.title.contains(searchLine)) {
                setState(() {
                  books.add(current.book);
                });
              }
              _booklistBloc.add(GetBooklist(searchLine));
              return false;
            } else if (current is BooklistLoading &&
                previous is! BooklistInitial) {
              // return false;
            }
            return true;
          },
          builder: (BuildContext context, state) {
            if (state is BooklistLoading) {
              return buildLoading();
            } else if (state is BooklistLoaded) {
              books = state.books.toList();
              return buildLoaded(books);
            } else {
              // if error
              return Center();
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildLoaded(List<Book> books) {
    return Column(
      children: [
        Flexible(
          child: books.length != 0
              ? ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) => _buildItem(books[index]),
                )
              : Center(
                  child: Text("No items found"),
                ),
        ),
      ],
    );
  }

  Widget _buildItem(Book book) {
    Image image = _getBookImage(book);
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
            child: image != null ? image : SizedBox.shrink(),
            width: 50,
          ),
          onTap: () {
            Navigator.of(context).push(_bookDetailsRoute(book));
          },
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            _deleteBook(book);
          },
        ),
      ],
    );
  }

  void _updateBookList() async {
    _booklistBloc.add(GetBooklist(searchLine));
  }

  void _deleteBook(book) async {
    _booklistBloc.add(DeleteBook(book));
  }

  void _addBook(Book book) async {
    _booklistBloc.add(AddBook(book));
  }

  Image _getBookImage(Book book) {
    if (book.image == null) {
      return null;
    } else {
      return Image.memory(book.image);
      // return Image.asset('assets/Images/${book.image}');
    }
  }

  Route _bookDetailsRoute(Book book) {
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

class SearchInputField extends StatelessWidget {
  final Function(String) onChanged;

  const SearchInputField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        onChanged: onChanged,
      ),
    );
  }
}
