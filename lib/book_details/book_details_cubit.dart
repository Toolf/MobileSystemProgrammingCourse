import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/models/api_models.dart';
import 'package:flutter_application_1/services/book_service.dart';
import 'package:meta/meta.dart';

part 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  final BookService _bookService;

  BookDetailsCubit(this._bookService) : super(BookDetailsInitial());

  void load(Book book) async {
    try {
      emit(BookDetailsLoading());
      final Book bookDetails = await _bookService.getBook(book.isbn13);
      emit(BookDetailsLoaded(bookDetails));
    } catch (e) {
      emit(BookDetailsError("Details information is not found"));
    }
  }
}
