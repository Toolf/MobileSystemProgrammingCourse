// This test check owner.

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Owner checker', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify owner.
    expect(find.text('Смірнов Назар\nГрупа ІО-81\nЗК ІО-8125'), findsOneWidget);
  });
}
