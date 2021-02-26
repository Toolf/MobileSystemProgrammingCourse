import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/services/exceptions.dart';
import 'package:flutter_application_1/services/gallery_service.dart';
import 'package:meta/meta.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final GalleryService _galleryService;

  ImageCubit(this._galleryService) : super(ImageInitial());

  void loadImage(String url) async {
    try {
      emit(ImageLoading());
      Uint8List image = await _galleryService.getImage(url);
      if (image == null) {
        throw NetworkException();
      }
      emit(ImageLoaded(image));
    } catch (e) {
      emit(ImageError("image not found"));
    }
  }
}
