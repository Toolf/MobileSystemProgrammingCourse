import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/gallery.dart';

import '../widgets/custom_painting.dart';
import '../widgets/person.dart';
import '../widgets/book_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Person(),
    DrawingCanvas(),
    BookList(),
    Gallery(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Person",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: "Pie",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: "Books",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: "Gallery",
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });
  }
}
