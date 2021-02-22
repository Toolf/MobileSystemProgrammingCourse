part of 'booklist_bloc.dart';

@immutable
abstract class BooklistEvent {}

class GetBooklist extends BooklistEvent {
  final String searchString;

  GetBooklist(this.searchString);
}

class DeleteBook extends BooklistEvent {
  final Book book;

  DeleteBook(this.book);
}

class AddBook extends BooklistEvent {
  final Book book;

  AddBook(this.book);
}
