import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/book_details/book_details_cubit.dart';
import 'package:flutter_application_1/models/api_models.dart';
import 'package:flutter_application_1/services/http_book_service.dart';
import 'package:flutter_application_1/services/mock_book_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookPage extends StatelessWidget {
  final double fontSize = 18;

  final BookDetailsCubit _bookDetailsCubit =
      BookDetailsCubit(HttpBookService());

  BookPage({
    Key key,
    @required Book book,
  }) : super(key: key) {
    _bookDetailsCubit.load(book);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bookDetailsCubit,
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder(
          cubit: _bookDetailsCubit,
          builder: (BuildContext context, state) {
            if (state is BookDetailsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BookDetailsLoaded) {
              return buildLoaded(state.book);
            } else {
              return Center(
                child: Text("Book details not found"),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildLoaded(Book book) {
    final Image image = _getBookImage(book);
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            image != null ? image : Container(),
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
        ),
      ),
    );
  }

  Image _getBookImage(Book book) {
    if (book.image == "") {
      return null;
    } else {
      return Image.network(book.image);
      // return Image.asset('assets/Images/${book.image}');
    }
  }
}
