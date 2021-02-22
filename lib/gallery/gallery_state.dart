part of 'gallery_cubit.dart';

@immutable
abstract class GalleryState {}

class GalleryInitial extends GalleryState {}

class GalleryLoading extends GalleryState {}

class GalleryLoaded extends GalleryState {
  final List<String> images;

  GalleryLoaded(this.images);
}

class GalleryError extends GalleryState {}
