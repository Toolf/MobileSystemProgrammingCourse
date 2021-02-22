import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class GalleryService {
  Future<List<String>> getImages();
}

class HttpGalleryService implements GalleryService {
  final String url =
      "https://pixabay.com/api/?key=19193969-87191e5db266905fe8936d565&q=hot+summer&image_type=photo&per_page=24";

  @override
  Future<List<String>> getImages() async {
    var response = await http.get(url);
    if (response.statusCode != 200) {
      return [];
    }
    dynamic body = jsonDecode(response.body);
    dynamic data = body['hits'];
    List<String> images = List();
    for (int i = 0; i < 24; i++) {
      images.add(data[i]['webformatURL']);
    }
    return images;
  }
}
