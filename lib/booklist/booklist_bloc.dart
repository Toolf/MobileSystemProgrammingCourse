import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/models/api_models.dart';
import 'package:flutter_application_1/services/book_service.dart';
import 'package:meta/meta.dart';

part 'booklist_event.dart';
part 'booklist_state.dart';

class BooklistBloc extends Bloc<BooklistEvent, BooklistState> {
  final BookService _bookService;

  BooklistBloc(this._bookService) : super(BooklistInitial());

  @override
  Stream<BooklistState> mapEventToState(
    BooklistEvent event,
  ) async* {
    if (event is GetBooklist) {
      yield BooklistLoading();
      final List<Book> books = await _bookService.getBooks(event.searchString);
      yield BooklistLoaded(books);
    } else if (event is DeleteBook) {
      await _bookService.removeBook(event.book);
      yield BooklistDeleted(event.book);
    } else if (event is AddBook) {
      await _bookService.addBook(event.book);
      yield BooklistAdded(event.book);
    }
  }
}
