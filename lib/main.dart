import 'package:flutter/material.dart';

import 'injection.dart';
import 'pages/home_page.dart';

void main() {
  config();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
