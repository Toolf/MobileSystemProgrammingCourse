import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_application_1/services/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class GalleryService {
  Future<List<String>> getImages();
  Future<Uint8List> getImage(String url);
}

class HttpGalleryService implements GalleryService {
  final String url =
      "https://pixabay.com/api/?key=19193969-87191e5db266905fe8936d565&q=hot+summer&image_type=photo&per_page=24";

  @override
  Future<List<String>> getImages() async {
    var response = await http.get(url).timeout(
      Duration(seconds: 3),
      onTimeout: () {
        throw NetworkException();
      },
    );
    if (response.statusCode != 200) {
      throw NetworkException();
    }
    dynamic body = jsonDecode(response.body);
    dynamic data = body['hits'];
    List<String> images = List();
    for (int i = 0; i < 24; i++) {
      images.add(data[i]['previewURL']);
    }
    return images;
  }

  Future<Uint8List> getImage(String url) async {
    var response = await http.get(url).timeout(
      Duration(seconds: 15),
      onTimeout: () {
        throw NetworkException();
      },
    );
    if (response.statusCode != 200) {
      throw NetworkException();
    }
    Uint8List image = Uint8List.fromList(response.body.codeUnits);
    return image;
  }
}
