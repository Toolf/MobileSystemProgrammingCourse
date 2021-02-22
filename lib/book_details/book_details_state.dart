part of 'book_details_cubit.dart';

@immutable
abstract class BookDetailsState {}

class BookDetailsInitial extends BookDetailsState {}

class BookDetailsLoading extends BookDetailsState {}

class BookDetailsLoaded extends BookDetailsState {
  final Book book;

  BookDetailsLoaded(this.book);
}

class BookDetailsError extends BookDetailsState {
  final String message;

  BookDetailsError(this.message);
}
