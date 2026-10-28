// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widgets/main.dart';

void main() {
  testWidgets('Renders contact tabs and navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Peoples'), findsWidgets);
    expect(find.text('Sofia Herrera'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);

    await tester.tap(find.text('Chats'));
    await tester.pumpAndSettle();

    expect(find.text('¿Puedes revisar el mockup antes de la reunión?'), findsOneWidget);
    expect(find.text('Sofia Herrera'), findsWidgets);

    await tester.tap(find.text('Calls'));
    await tester.pumpAndSettle();

    expect(find.text('Hoy, 09:42'), findsOneWidget);
  });
}
