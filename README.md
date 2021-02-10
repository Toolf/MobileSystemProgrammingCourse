# Lab 4

Виконав: <br/>
Студент групи: ІО-81 <br/>
ЗК: ІО-8125 <br/>
Смірнов Назар <br/>

## Варіант №2

1. Візьміть за основу проект із лабораторної роботи 3.
2. В даній роботі необхідно розширити функціональність створеного у попередній роботі екрану списку сутностей.
3. Предметну область визначте за варіантом, де варіант = (номер залікової книжки mod 2) + 1, завантажте відповідний архів з файлами, додайте файли до проекту: файли <movie_id>.txt або <book_id>.txt, містять в собі розширені дані про модельні сутності у форматі JSON.
   | Варіант 1 | Варіант 2 |
   |-----------|-----------|
   |Предметна область – фільми | Предметна область – книги |
4. Розширте, створений у попередній роботі клас, який представляє модельну сутність: додайте нові поля до класу (перегляньте вихідні дані з файлів <movie_id>.txt або <book_id>.txt).
5. Додайте новий екран, на якому відображатиметься повна інформація про сутність. При кліку на рядок таблиці зі списком сутностей, повинен відкритися екран з повною інформацією про відповідну сутність (повна інформація про сутність зчитується з файлів <movie_id>.txt або <book_id>.txt).
6. Додайте поле для пошуку на екран зі списком сутностей. Після введення запиту необхідно відобразити відфільтрований список сутностей. Можете виконувати фільтрацію по будь-якому полю сутності. В прикладі, який наведений в кінці документу, фільтрація відбувається по назві сутності. Якщо відфільтрований список порожній, необхідно відобразити повідомлення про це.
7. Додайте новий екран для додавання нової сутності до списку. При створенні сутності використовуйте тільки базові поля, які необхідні для відображення у списку сутностей. Не забудьте про валідацію полів: наприклад, рік (для фільму) та ціна (для книги) може мати тільки цифрове значення. Створена сутність фільму повинна бути додана до існуючого списку і відобразитися у таблиці.
8. Додайте функціональність видалення сутності із списку фільмів (стандартний функціонал видалення із таблиці в iOS – свайп відповідного рядка вліво).
9. Переконайтеся, що можете запустити проект, та що все працює коректно.
10. Закомітьте та відправте ваш проект до будь-якої системи контролю версій.
11. Підготуйте протокол за шаблоном.
12. Надішліть виконане завдання через Google Classroom - додайте посилання до вашого проекту та протокол.

## приклад роботи додатка

Приклад роботи в портретному режимі
(відео в .mp4 лижить в readme_images)
![](readme_images/portrait_video.gif)
Приклад роботи в портретному режимі
(відео в .mp4 лижить в readme_images)
![](readme_images/landscape_video.gif)

## Лістинг коду

```dart {.line-numbers}
// main.dart

import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
```

```dart {.line_numbers}
// models/api_models.dart

import 'package:flutter/material.dart';

@immutable
class Book {
  final String title;
  final String subtitle;
  final String isbn13;
  final String price;
  final Image image;

  final String authors;
  final String publisher;
  final String pages;
  final String year;
  final String rating;
  final String desc;

  const Book({
    @required this.title,
    @required this.subtitle,
    @required this.price,
    this.isbn13,
    this.image,
    this.publisher,
    this.pages,
    this.year,
    this.rating,
    this.desc,
    this.authors,
  });

  Book.fromJson(dynamic json)
      : this(
          title: json['title'],
          subtitle: json['subtitle'],
          isbn13: json['isbn13'],
          price: json['price'],
          image: json['image'] != ""
              ? Image.asset('assets/Images/${json['image']}')
              : null,
          publisher: json['publisher'],
          pages: json['pages'],
          year: json['year'],
          rating: json['rating'],
          desc: json['desc'],
          authors: json['authors'],
        );

  @override
  String toString() {
    return 'Book: {title: $title, subtitle: $subtitle, isbn13: $isbn13, price: $price, image: $image}';
  }
}
```

```dart {.line-numbers}
// pages/home_page.dart

import 'package:flutter/material.dart';

import '../widgets/custom_painting.dart';
import '../widgets/person.dart';
import '../widgets/book_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Person(),
    DrawingCanvas(),
    BookList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Person",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: "Pie",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: "Books",
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
```

```dart {.line-numbers}
// pages/book_add.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/api_models.dart';

class BookAdd extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController subtitleEditingController = TextEditingController();
  TextEditingController priceEditingController = TextEditingController();

  final Function onValid;

  BookAdd({Key key, @required this.onValid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: titleEditingController,
                  decoration: InputDecoration(
                    labelText: "Title",
                  ),
                ),
                TextFormField(
                  controller: subtitleEditingController,
                  decoration: InputDecoration(
                    labelText: "Subtitle",
                  ),
                ),
                TextFormField(
                  controller: priceEditingController,
                  decoration: InputDecoration(
                    labelText: "Price",
                  ),
                  validator: (String value) {
                    if (double.tryParse(value) != null) {
                      return null;
                    }
                    return 'Please enter float number.';
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        onValid(
                          Book(
                            title: titleEditingController.text,
                            subtitle: subtitleEditingController.text,
                            price: '\$${priceEditingController.text}',
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Add'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

```dart {.line-numbers}
// pages/book_details.dart

import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/api_models.dart';

class BookPage extends StatelessWidget {
  final Book book;
  final double fontSize = 18;

  const BookPage({
    Key key,
    @required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;

    // Orientation orientation = MediaQuery.of(context).orientation;

    // if (orientation == Orientation.portrait) {
    //   content = portraitView();
    // } else {
    //   content = landscapeView();
    // }
    content = view();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: content,
        ),
      ),
    );
  }

  Widget view() {
    return Column(
      children: [
        Hero(
          tag: "book-${book.title}",
          child: book.image != null ? book.image : Container(),
        ),
        Container(
          width: window.physicalSize.width,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Title: ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: fontSize,
                        ),
                      ),
                      TextSpan(
                        text: book.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Subtitle: ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: fontSize,
                        ),
                      ),
                      TextSpan(
                        text: book.subtitle,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Description: ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: fontSize,
                        ),
                      ),
                      TextSpan(
                        text: book.desc,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30,
                ),
                RichText(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Authors: ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: fontSize,
                        ),
                      ),
                      TextSpan(
                        text: book.authors,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Publisher: ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: fontSize,
                        ),
                      ),
                      TextSpan(
                        text: book.publisher,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30,
                ),
                RichText(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Pages: ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: fontSize,
                        ),
                      ),
                      TextSpan(
                        text: book.pages,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Year: ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: fontSize,
                        ),
                      ),
                      TextSpan(
                        text: book.year,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Rating: ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: fontSize,
                        ),
                      ),
                      TextSpan(
                        text: book.rating,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
```

```dart {.line-numbers}
// widgets/book_list.dart

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
```

```dart {.line-numbers}
// services/book_service.dart

import 'package:flutter_application_1/models/api_models.dart';

abstract class BookService {
  Future<List<Book>> getBooks();

  Future<Book> getBook(String isbn13);
}
```

```dart {.line-numbers}
// services/local_book_service.dart
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/api_models.dart';

import 'book_service.dart';

class LocalBookService implements BookService {
  @override
  Future<List<Book>> getBooks() async {
    try {
      // Read the file.
      String data = await rootBundle.loadString('assets/BooksList.txt');
      dynamic jsonBooks = jsonDecode(data);
      List<Book> books = List();

      for (dynamic book in jsonBooks['books']) {
        books.add(Book.fromJson(book));
      }
      return books;
    } catch (e) {
      // If encountering an error, return [].
      return [];
    }
  }

  @override
  Future<Book> getBook(String isbn13) async {
    try {
      // Read the file.
      String data = await rootBundle.loadString('assets/id/$isbn13.txt');

      dynamic jsonBook = jsonDecode(data);
      Book book = Book.fromJson(jsonBook);
      return book;
    } catch (e) {
      // If encountering an error, return null.
      return null;
    }
  }
}
```

## Висновок

В даній лабораторній роботі було розширено модель Book, добалена можливість дізнавання розширеної інформації про конкретну книжку, надана можливість пошуку, видалення та додавання книжки, а такаж перегляд розширеної інформації.
