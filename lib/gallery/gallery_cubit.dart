import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/services/gallery_service.dart';
import 'package:meta/meta.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  final GalleryService _galleryService;

  GalleryCubit(this._galleryService) : super(GalleryInitial());

  void loadImages() async {
    emit(GalleryLoading());
    final images = await _galleryService.getImages();
    emit(GalleryLoaded(images));
  }
}
