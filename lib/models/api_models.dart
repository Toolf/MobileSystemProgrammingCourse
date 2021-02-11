import 'package:flutter/material.dart';

@immutable
class Book {
  final String title;
  final String subtitle;
  final String isbn13;
  final String price;
  final String image;

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
          image: json['image'],
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
