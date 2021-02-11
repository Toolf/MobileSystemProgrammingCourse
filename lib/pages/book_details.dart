import 'dart:ui';

import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  final double fontSize = 18;

  final String price;
  final String title;
  final String subtitle;
  final String isbn13;
  final Image image;
  final String publisher;
  final String pages;
  final String year;
  final String rating;
  final String desc;
  final String authors;

  const BookPage({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.price,
    this.isbn13 = "",
    this.image,
    this.publisher = "",
    this.pages = "",
    this.year = "",
    this.rating = "",
    this.desc = "",
    this.authors = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;

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
          tag: "book-$title",
          child: image != null ? image : Container(),
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
                        text: title,
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
                        text: subtitle,
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
                        text: desc,
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
                        text: authors,
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
                        text: publisher,
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
                        text: pages,
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
                        text: year,
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
                        text: rating,
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
