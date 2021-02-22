import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/gallery/gallery_cubit.dart';
import 'package:flutter_application_1/services/gallery_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:image_picker/image_picker.dart';

class Gallery extends StatefulWidget {
  Gallery({Key key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return MyImagePicker(
      initCount: 24,
      build: (context, images) => StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: images[index],
            color: Colors.grey[300],
          );
        },
        staggeredTileBuilder: (int index) => StaggeredTile.count(
            (index % 8 == 1) ? 3 : 1, (index % 8 == 1) ? 3 : 1),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
    );
  }
}

class MyImagePicker extends StatefulWidget {
  final Function(BuildContext context, List<Image> images) build;
  final int initCount;

  MyImagePicker({
    Key key,
    this.build,
    this.initCount,
  }) : super(key: key);

  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  final GalleryCubit _galleryCubit = GalleryCubit(HttpGalleryService());

  List<Image> images;
  selectImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        images.add(Image.file(image));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    images = List();
    final String image =
        "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAIAAACQd1PeAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAAMSURBVBhXY/j//z8ABf4C/qc1gYQAAAAASUVORK5CYII=";
    for (int i = 0; i < widget.initCount; i++) {
      images.add(Image.memory(
        base64.decode(image),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: CircularProgressIndicator(),
          );
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await selectImage();
          },
          child: Icon(Icons.add_photo_alternate)),
      body: BlocProvider(
        create: (context) => _galleryCubit,
        child: BlocBuilder(
          cubit: _galleryCubit,
          builder: (context, state) {
            if (state is GalleryInitial) {
              _galleryCubit.loadImages();
            }
            if (state is GalleryLoaded) {
              for (int i = 0; i < state.images.length; i++) {
                images[i] = Image.network(
                  state.images[i],
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              }
              return widget.build(context, images);
            } else {
              return widget.build(context, images);
            }
          },
        ),
      ),
    );
  }
}

class RK5CYII {}
