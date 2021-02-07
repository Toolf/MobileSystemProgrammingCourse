import 'package:flutter/material.dart';

class Person extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Смірнов Назар'
              '\nГрупа ІО-81'
              '\nЗК ІО-8125',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28),
            ),
          ],
        ),
      ),
    );
  }
}
