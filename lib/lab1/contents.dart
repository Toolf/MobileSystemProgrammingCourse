import 'dart:math';

var randomer = Random();

int randomValue(int maxValue) {
  switch (randomer.nextInt(6)) {
    case 1:
      return (maxValue * 0.7).ceil();
    case 2:
      return (maxValue * 0.9).ceil();
    case 3:
    case 4:
    case 5:
      return maxValue;
    default:
      return 0;
  }
}

void main(List<String> args) {
  // Частина 1

  // Дано рядок у форматі "Student1 - Group1; Student2 - Group2; ..."

  String studentsStr =
      "Дмитренко Олександр - ІП-84; Матвійчук Андрій - ІВ-83; Лесик Сергій - ІО-82; Ткаченко Ярослав - ІВ-83; Аверкова Анастасія - ІО-83; Соловйов Даніїл - ІО-83; Рахуба Вероніка - ІО-81; Кочерук Давид - ІВ-83; Лихацька Юлія - ІВ-82; Головенець Руслан - ІВ-83; Ющенко Андрій - ІО-82; Мінченко Володимир - ІП-83; Мартинюк Назар - ІО-82; Базова Лідія - ІВ-81; Снігурець Олег - ІВ-81; Роман Олександр - ІО-82; Дудка Максим - ІО-81; Кулініч Віталій - ІВ-81; Жуков Михайло - ІП-83; Грабко Михайло - ІВ-81; Іванов Володимир - ІО-81; Востриков Нікіта - ІО-82; Бондаренко Максим - ІВ-83; Скрипченко Володимир - ІВ-82; Кобук Назар - ІО-81; Дровнін Павло - ІВ-83; Тарасенко Юлія - ІО-82; Дрозд Світлана - ІВ-81; Фещенко Кирил - ІО-82; Крамар Віктор - ІО-83; Іванов Дмитро - ІВ-82";
  // Завдання 1
  // Заповніть словник, де:
  // - ключ – назва групи
  // - значення – відсортований масив студентів, які відносяться до відповідної групи

  Map<String, List<String>> studentsGroups = Map();

  // Ваш код починається тут

  var students = studentsStr.split(";");
  for (var student_line in students) {
    var studentInfo = student_line.split(" - ");
    String studentName = studentInfo[0];
    String studentGroup = studentInfo[1];
    if (studentsGroups.containsKey(studentGroup)) {
      studentsGroups[studentGroup].add(studentName);
    } else {
      studentsGroups[studentGroup] = [studentName];
    }
  }

  for (var studentGroup in studentsGroups.keys) {
    studentsGroups[studentGroup].sort();
  }

  // Ваш код закінчується тут

  print("Завдання 1");
  print(studentsGroups);
  print('\n');

  // Дано масив з максимально можливими оцінками

  List<int> points = [12, 12, 12, 12, 12, 12, 12, 16];

  // Завдання 2
  // Заповніть словник, де:
  // - ключ – назва групи
  // - значення – словник, де:
  //   - ключ – студент, який відносяться до відповідної групи
  //   - значення – масив з оцінками студента (заповніть масив випадковими значеннями, використовуючи функцію `randomValue(maxValue: Int) -> Int`)

  Map<String, Map<String, List<int>>> studentPoints = Map();

  // Ваш код починається тут

  for (String groupName in studentsGroups.keys) {
    Map<String, List<int>> groupPoints = Map();
    for (String studentName in studentsGroups[groupName]) {
      List<int> pointsList = List();
      for (int maxValue in points) {
        pointsList.add(randomValue(maxValue));
      }
      groupPoints[studentName] = pointsList;
    }
    studentPoints[groupName] = groupPoints;
  }

  // Ваш код закінчується тут

  print("Завдання 2");
  print(studentPoints);
  print('\n');

  // Завдання 3
  // Заповніть словник, де:
  // - ключ – назва групи
  // - значення – словник, де:
  //   - ключ – студент, який відносяться до відповідної групи
  //   - значення – сума оцінок студента

  Map<String, Map<String, int>> sumPoints = Map();

  // Ваш код починається тут

  for (String groupName in studentPoints.keys) {
    Map<String, int> groupMarks = Map();
    for (String studentName in studentPoints[groupName].keys) {
      groupMarks[studentName] = studentPoints[groupName][studentName]
          .reduce((sum, value) => sum + value);
    }
    sumPoints[groupName] = groupMarks;
  }

  // Ваш код закінчується тут

  print("Завдання 3");
  print(sumPoints);
  print('\n');

  // Завдання 4
  // Заповніть словник, де:
  // - ключ – назва групи
  // - значення – середня оцінка всіх студентів групи

  Map<String, double> groupAvg = Map();

  // Ваш код починається тут

  for (String groupName in sumPoints.keys) {
    groupAvg[groupName] =
        sumPoints[groupName].values.reduce((sum, value) => sum + value) /
            sumPoints[groupName].length;
  }

  // Ваш код закінчується тут

  print("Завдання 4");
  print(groupAvg);
  print('\n');

  // Завдання 5
  // Заповніть словник, де:
  // - ключ – назва групи
  // - значення – масив студентів, які мають >= 60 балів

  Map<String, List<String>> passedPerGroup = Map();

  // Ваш код починається тут

  for (String groupName in sumPoints.keys) {
    List<String> passed = List();
    passed = List.of(sumPoints[groupName]
        .keys
        .where((student) => sumPoints[groupName][student] >= 60));

    passedPerGroup[groupName] = passed;
  }

  // Ваш код закінчується тут
  print("Завдання 5");
  print(passedPerGroup);

  // Приклад виведення. Ваш результат буде відрізнятися від прикладу через використання функції random для заповнення масиву оцінок та через інші вхідні дані.
  //
  //Завдання 1
  //["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
  //
  //Завдання 2
  //["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
  //
  //Завдання 3
  //["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
  //
  //Завдання 4
  //["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
  //
  //Завдання 5
  //["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]
}
