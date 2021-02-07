# Lab 1

Виконав:
Студент групи: ІО-81
ЗК: ІО-8125
Смірнов Назар

## Варіант №2

1. Завантажте архів за посиланням та виконайте описані задачі.
2. Використайте файл playground з частини 1. Створіть клас, визначений за варіантом, де варіант = (номер залікової книжки mod 2) + 1.
3. Створіть клас CoordinateXY, який представляє координату (не локацію, оскільки локація складається із двох координат), де X перша літера вашого імені, Y перша літера вашого прізвища.
4. Створіть перерахування Direction, що представляє напрямок/позицію (широта, довгота).
5. Додайте властивість типу Direction у клас CoordinateXY.
6. Додайте властивість типу Int та дві властивості типу UInt в клас CoordinateXY для представлення градусів, мінут та секунд відповідно.
7. Додайте методи ініціалізації:
   a) з нульовими значеннями за замовчанням;
   б) з заданим набором значень (градуси, мінути, секунди) (перевірте вхідні значення – градуси ∈ [-90, 90] для широти / [-180, 180] для довготи, мінути ∈ [0, 59], секунди ∈ [0, 59]).
8. Додайте методи, що повертають:
   а) значення типу String у форматі “xx°yy′zz″ Z”, де xx – градуси, yy – мінути, zz – секунди, Z – N/S/W/E (залежить від Direction);
   б) значення типу String у форматі “xx,xxx...° Z”, де xx,xxx... – десяткове значення координати, Z – N/S/W/E (залежить від Direction);
9. об'єкт типу CoordinateXY, що представляє середню координату між координатами, що представлені поточним об'єктом та об'єктом, що отриманий як вхідний параметр, або nil, якщо об'єкти мають різний напрямок/позицію (Direction).
10. Додайте методи класу, що повертають:
    а) об'єкт типу CoordinateXY, що представляє середню координату між координатами, що представлені двома об'єктами, що отримані як вхідні параметри, або nil, якщо об'єкти мають різний напрямок/позицію (Direction).
11. Створіть декілька об'єктів типу CoordinateXY за допомогою різних ініціалізаторів (методи з кроку 15).
12. Продемонструйте використання методів з кроків 16 та 17 (виведіть результати).
13. Закомітьте та відправте ваш проект до будь-якої системи контролю версій
14. Підготуйте протокол за шаблоном.
15. Надішліть виконане завдання через Google Classroom - додайте посилання до вашого проекту та протокол.

## Скріншот роботи додатка

Перша сторінка:
![](readme_images/personal_page.png)

Друга Сторінка:
![](readme_images/other_page.png)

Іконка:
![](readme_images/show_icon.png)

## Лістинг коду

```dart {.line-numbers}
// lib/main.dart

import 'package:flutter/material.dart';

import 'home_widget.dart';

void main() {
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
```

```dart {.line-numbers}
// lib/home_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/person_widget.dart';

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
    Scaffold(), // заглушка
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
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
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
```

```dart {.line-numbers highlight=14-16}
// lib/person_widget.dart

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
```

## Висновок

В даній лабораторній роботі було настоїно середовище розробки. Був створений перший проект, добавлені іконки програми. В програму було додано елемент навігації. Програма була успішно скомпільона та перевірина на працездатність.
