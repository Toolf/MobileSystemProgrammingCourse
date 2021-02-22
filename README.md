# Lab 6

Виконав: <br/>
Студент групи: ІО-81 <br/>
ЗК: ІО-8125 <br/>
Смірнов Назар <br/>

## Варіант №2

1. Візьміть за основу проект із лабораторної роботи 4.
2. Додайте четверту вкладку у контейнерний вигляд UITabBarController. Вкажіть будь-яку назву та зображення за бажанням, які відрізняються від стандартних, для вкладки. На екрані четвертої вкладки буде відображатися колекція картинок.
3. Додайте вигляд колекції (UICollectionView) на екран. Кожна комірка колекції (UICollectionViewCell) буде відображати зображення (UIImage). Додайте до комірки колекції вигляд для відображення зображення (UIImageView). Ширина колекції повинна дорівнювати ширині екрану, вміст колекції прокручується вертикально.
4. Забезпечте можливість відображати у колекції зображення, які користувач буде обирати із системної галереї зображень за допомогою контролера вигляду, що надає системний інтерфейс (UIImagePickerController). Додайте кнопку (або будь-який інший елемент керування), при натисканні на яку, відкривається контролер вигляду, що представляє системну галерею зображень. Після того як користувач обирає зображення, контролер вигляду, що представляє системну галерею зображень, закривається, і зображення додається та відображається у колекції.
5. Сітку для розташування та відносних розмірів комірок колекції оберіть за варіантом, де варіант = (номер залікової книжки mod 6) + 1. Зображена частина сітки, що повторюється, цифрою показаний відносний розмір кожної комірки. (Приклад – сітка з рекомендаціями на вкладці пошуку в додатку Instagram).
6. Переконайтеся, що можете запустити проект, та що все працює коректно.
7. Закомітьте та відправте ваш проект до будь-якої системи контролю версій.
8. Підготуйте протокол за шаблоном.
9. Надішліть виконане завдання через Google Classroom - додайте посилання до вашого проекту та протокол.

## приклад роботи додатка

Приклад роботи в портретному режимі
(відео в .mp4 лижить в readme_images)
![](readme_images/portrait_video.gif)
<br/>
Приклад роботи в портретному режимі
(відео в .mp4 лижить в readme_images)
![](readme_images/landscape_video.gif)

## Лістинг коду

```dart {.line-numbers}
// book_list.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/booklist/booklist_bloc.dart';
import 'package:flutter_application_1/services/mock_book_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import '../pages/book_add.dart';
import '../pages/book_details.dart';
import '../services/book_service.dart';
import '../services/local_book_service.dart';
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

  GlobalKey<AnimatedListState> _anim = GlobalKey();
  final BooklistBloc _booklistBloc = BooklistBloc(HttpBookService());

  @override
  void initState() {
    super.initState();
    // _updateBookList();
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
                });
                _updateBookList();
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
              return false;
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
    if (book.image == "") {
      return null;
    } else {
      return Image.network(book.image);
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
```

```dart {.line-numbers}
// gallery.dart

import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/gallery/gallery_cubit.dart';
import 'package:flutter_application_1/services/gallery_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:image_picker/image_picker.dart';

class Gallery extends StatefulWidget {
  Gallery({Key key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return MyImagePicker(
      initCount: 24,
      build: (context, images) => StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: images[index],
            color: Colors.grey[300],
          );
        },
        staggeredTileBuilder: (int index) => StaggeredTile.count(
            (index % 8 == 1) ? 3 : 1, (index % 8 == 1) ? 3 : 1),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
    );
  }
}

class MyImagePicker extends StatefulWidget {
  final Function(BuildContext context, List<Image> images) build;
  final int initCount;

  MyImagePicker({
    Key key,
    this.build,
    this.initCount,
  }) : super(key: key);

  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  final GalleryCubit _galleryCubit = GalleryCubit(HttpGalleryService());

  List<Image> images;
  selectImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        images.add(Image.file(image));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    images = List();
    final String image =
        "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAIAAACQd1PeAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAAMSURBVBhXY/j//z8ABf4C/qc1gYQAAAAASUVORK5CYII=";
    for (int i = 0; i < widget.initCount; i++) {
      images.add(Image.memory(
        base64.decode(image),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: CircularProgressIndicator(),
          );
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await selectImage();
          },
          child: Icon(Icons.add_photo_alternate)),
      body: BlocProvider(
        create: (context) => _galleryCubit,
        child: BlocBuilder(
          cubit: _galleryCubit,
          builder: (context, state) {
            if (state is GalleryInitial) {
              _galleryCubit.loadImages();
            }
            if (state is GalleryLoaded) {
              for (int i = 0; i < state.images.length; i++) {
                images[i] = Image.network(
                  state.images[i],
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              }
              return widget.build(context, images);
            } else {
              return widget.build(context, images);
            }
          },
        ),
      ),
    );
  }
}
```

## Висновок

Вданій лабораторній роботі було використано сторонній api для отримання даних прикладної області, даних про книг та катринки для гелереї. Загрузка даних зроблена асинхронно для того щоб не блокувати основний потік виконання програми.
