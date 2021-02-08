import 'package:flutter/material.dart';
// "subtitle":"",
//         "isbn13":"noid",
//         "price":"Priceless",
//         "image":""}

@immutable
class Book {
  final String title;
  final String subtitle;
  final String isbn13;
  final String price;
  final String image;

  const Book({
    @required this.title,
    @required this.subtitle,
    @required this.isbn13,
    @required this.price,
    @required this.image,
  });

  Book.fromJson(dynamic json)
      : this(
          title: json['title'],
          subtitle: json['subtitle'],
          isbn13: json['isbn13'],
          price: json['price'],
          image: json['image'],
        );

  @override
  String toString() {
    return 'Book: {title: $title, subtitle: $subtitle, isbn13: $isbn13, price: $price, image: $image}';
  }
}
