import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/services/book_service.dart';
import 'package:flutter_application_1/services/local_book_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'models/api_models.dart';

class BookList extends StatefulWidget {
  final BookService bookService = LocalBookService();

  BookList({Key key}) : super(key: key);

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<Book> books = List();
  List<Widget> bookWidgets = List();

  final GlobalKey<AnimatedListState> _anim = GlobalKey();

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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(),
      body: AnimatedList(
        key: _anim,
        initialItemCount: bookWidgets.length,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: bookWidgets[index],
          );
        },
      ),
    );
  }

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

  Future<Widget> _buildItem(Book book) async {
    Widget image;
    if (book.image != "") {
      image = await _getImage('assets/Images/${book.image}');
    } else {
      image = await _getImage(null); // return default image
    }
    return Slidable(
      key: Key(book.title),
      actionPane: SlidableBehindActionPane(),
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
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            _removeBook(book);
          },
        ),
      ],
    );
  }

  void _removeBook(book) async {
    Widget bookWidget = await _buildItem(book);
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Opacity(opacity: 0.0, child: bookWidget),
      );
    };

    var index = books.indexOf(book);
    _anim.currentState.removeItem(
      index,
      builder,
    );

    setState(() {
      books.removeAt(index);
      bookWidgets.removeAt(index);
    });
  }
}
