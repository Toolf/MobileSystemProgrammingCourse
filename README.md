# Lab 6

Виконав: <br/>
Студент групи: ІО-81 <br/>
ЗК: ІО-8125 <br/>
Смірнов Назар <br/>

## Варіант №2

1. Візьміть за основу проєкт із лабораторної роботи 5.
2. Додайте функціональність завантаження даних з мережі для вмісту двох останніх вкладок у додатку (список сутностей, детальна інформація про сутність, колекція зображень).
3. Модифікуйте логіку відображення списку сутностей на третій вкладці:
   a) при заході на екран відображається порожній список сутностей;
   b) якщо в поле для пошуку ввести запит, то необхідно завантажити список сутностей з мережі за даним запитом та відобразити його;
   c) завантажувати список необхідно тільки, якщо в поле для пошуку введено принаймні 3 символи, інакше повинен відображатися порожній список;
   d) предметну область визначте за варіантом, де варіант = (номер залікової книжки mod 2) + 1:

| Варіант 1                                                                                                                                                                                                                 | Варіант 2                                                                                                            |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| Предметна область – фільми                                                                                                                                                                                                | Предметна область – книги                                                                                            |
| URL-адреса для отримання даних – http://www.omdbapi.com/?apikey=API_KEY&s=REQUEST&page=1, де API_KEY – 7e9fe69e, REQUEST – запит із поля для пошуку.                                                                      | URL-адреса для отримання даних – https://api.itbook.store/1.0/search/REQUEST, де REQUEST – запит із поля для пошуку. |
| Зверніть увагу на те, що використання ключа API_KEY обмежене до 1000 запитів на день, якщо буде вичерпано кількість запитів на день для наведеного ключа, то можна отримати власний ключ, зареєструвавшись за посиланням. |

e) додайте відображення анімації індикатора активності (UIActivityIndicatorView) під час завантаження даних. 4. Модифікуйте логіку відображення екрану з повною інформацією про сутність:
a) при кліку на комірку таблиці зі списком сутностей, необхідно завантажити повну інформацію про сутність з мережі та відкрити екран, де буде відображатися ця інформація;
b) предметну область визначте за варіантом, де варіант = (номер залікової книжки mod 2) + 1:

| Варіант 1                                                                                                                                                                                                                 | Варіант 2                                                                                                                                                       |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Предметна область – фільми                                                                                                                                                                                                | Предметна область – книги                                                                                                                                       |
| URL-адреса для отримання даних – http://www.omdbapi.com/?apikey=API_KEY&i=IDENTIFIER, де API_KEY – 7e9fe69e, IDENTIFIER – ідентифікатор відповідного фільму (поле imdbID із сутності фільму).                             | URL-адреса для отримання даних – https://api.itbook.store/1.0/books/IDENTIFIER, де IDENTIFIER – ідентифікатор відповідної книги (поле isbn13 із сутності книги) |
| Зверніть увагу на те, що використання ключа API_KEY обмежене до 1000 запитів на день, якщо буде вичерпано кількість запитів на день для наведеного ключа, то можна отримати власний ключ, зареєструвавшись за посиланням. |

c) додайте відображення анімації індикатора активності (UIActivityIndicatorView) під час завантаження даних. 5. Модифікуйте логіку відображення колекції зображень на четвертій вкладці:
a) при заході на екран відображається порожня колекція зображень, після цього необхідно завантажити список зображень з мережі та відобразити його;
b) використовуйте наступну URL-адресу для отримання даних: https://pixabay.com/api/?key=API_KEY&q=REQUEST&image_type=photo&per_page=COUNT, де API_KEY – 19193969-87191e5db266905fe8936d565, REQUEST та COUNT – оберіть із таблиці за варіантом нижче, де варіант = (номер залікової книжки mod 6) + 1;
| Варіант 1 | Варіант 2 |
| --------- | --------- |
| REQUEST – “yellow+flowers” | REQUEST – “hot+summer” |
| COUNT – 27 | COUNT – 24 |

| Варіант 3                 | Варіант 4              |
| ------------------------- | ---------------------- |
| REQUEST – “small+animals” | REQUEST – “night+city” |
| COUNT – 18                | COUNT – 27             |

| Варіант 5             | Варіант 6            |
| --------------------- | -------------------- |
| REQUEST – “fun+party” | REQUEST – “red+cars” |
| COUNT – 30            | COUNT – 21           |

c) зверніть увагу на те, що використання ключа API_KEY обмежене до 5000 запитів на годину, якщо буде вичерпано кількість запитів на годину для наведеного ключа, то можна отримати власний ключ, зареєструвавшись за посиланням;
d) додайте відображення анімації індикатора активності (UIActivityIndicatorView) під час завантаження даних.

6. Зверніть увагу на те, що комірки таблиці та колекції перевикористовуються, а завантаження зображень сутностей, що відображаються в комірках, зазвичай відбувається асинхронно, тому поширена ситуація, коли завантажене зображення встановлюється в комірку, яка вже не відображає сутність, до якої відноситься зображення.
7. Зверніть увагу на те, що завантаження даних не повинно відбуватися на головному потоці додатка, оскільки це тривала операція і не потрібно в цей час повністю блокувати роботу додатка.
8. Зверніть увагу на те, що в поле пошуку можливо ввести не латинські літери або спеціальні символи, тому потрібно передбачити таку ситуацію, щоб додаток її правильно обробив.
9. Переконайтеся, що можете запустити проєкт, та що все працює коректно.
10. Закомітьте та відправте ваш проєкт до будь-якої системи контролю версій.
11. Підготуйте протокол за шаблоном.
12. Надішліть виконане завдання через Google Classroom - додайте посилання до вашого проєкту та протокол.

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
