part of 'booklist_bloc.dart';

@immutable
abstract class BooklistState {}

class BooklistInitial extends BooklistState {}

class BooklistLoading extends BooklistState {}

class BooklistLoaded extends BooklistState {
  final List<Book> books;

  BooklistLoaded(this.books);
}

class BooklistError extends BooklistState {
  final String message;

  BooklistError(this.message);
}

class BooklistDeleted extends BooklistState {
  final Book book;

  BooklistDeleted(this.book);
}

class BooklistAdded extends BooklistState {
  final Book book;

  BooklistAdded(this.book);
}
