import 'dart:typed_data';

import 'package:flutter_application_1/databases/db_provider.dart';
import 'package:flutter_application_1/services/exceptions.dart';
import 'package:flutter_application_1/services/gallery_service.dart';

abstract class GallaryServiceDecorator extends GalleryService {
  GalleryService get galleryService;
}

class SqliteGalleryServiceDecorator implements GallaryServiceDecorator {
  final DBProvider db = DBProvider.db;
  final GalleryService _galleryService;

  SqliteGalleryServiceDecorator(this._galleryService);

  @override
  GalleryService get galleryService => _galleryService;

  @override
  Future<Uint8List> getImage(String url) async {
    try {
      var res = await db.getImage(url);
      if (res != null) {
        return res;
      }
      final image = await galleryService.getImage(url);
      db.newImage(url, image);
      return image;
    } on NetworkException {
      return await db.getImage(url);
    }
  }

  @override
  Future<List<String>> getImages() async {
    try {
      final urls = await galleryService.getImages();
      await db.newImages(urls);
      return urls;
    } on NetworkException {
      return db.getImages();
    }
  }
}
