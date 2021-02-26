import 'package:flutter_application_1/services/book_service.dart';
import 'package:flutter_application_1/services/book_service_decorator.dart';
import 'package:flutter_application_1/services/gallery_service.dart';
import 'package:flutter_application_1/services/gallery_service_decorator.dart';
import 'package:flutter_application_1/services/http_book_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void config() {
  getIt.registerSingleton<BookService>(
    SqliteBookServiceDecorator(
      HttpBookService(),
    ),
  );
  getIt.registerSingleton<GalleryService>(
    SqliteGalleryServiceDecorator(
      HttpGalleryService(),
    ),
  );
}
