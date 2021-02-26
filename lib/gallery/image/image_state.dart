part of 'image_cubit.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final Uint8List image;

  ImageLoaded(this.image);
}

class ImageError extends ImageState {
  final String message;

  ImageError(this.message);
}
