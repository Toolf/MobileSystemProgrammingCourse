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
