import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

@immutable
class Book {
  final String title;
  final String subtitle;
  final String isbn13;
  final String price;
  final Uint8List image;

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
    this.isbn13 = "",
    this.publisher = "",
    this.pages = "",
    this.year = "",
    this.rating = "",
    this.desc = "",
    this.authors = "",
    this.image,
  });

  @override
  String toString() {
    return 'Book: {title: $title, subtitle: $subtitle, isbn13: $isbn13, price: $price, image: $image}';
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'isbn13': isbn13,
      'price': price,
      'image': image == null ? "" : image,
      'authors': authors,
      'publisher': publisher,
      'pages': pages,
      'year': year,
      'rating': rating,
      'desc': desc,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Book(
      title: map['title'],
      subtitle: map['subtitle'],
      isbn13: map['isbn13'],
      price: map['price'],
      image: map['image'] != "" ? map['image'] : null,
      authors: map['authors'] == null ? "" : map['authors'],
      publisher: map['publisher'] == null ? "" : map['publisher'],
      pages: map['pages'] == null ? "" : map['pages'],
      year: map['year'] == null ? "" : map['year'],
      rating: map['rating'] == null ? "" : map['rating'],
      desc: map['desc'] == null ? "" : map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));
}
