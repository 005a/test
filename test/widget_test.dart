// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test/logic/init.dart';
import 'package:test/logic/taskManager.dart';
import 'package:test/main.dart';

import 'mock.dart';

void main() {
  testWidgets('has dashboard', (WidgetTester tester) async {
    await initHive();
    await tester.pumpWidget(wrapWithMaterial(const MyHomePage(
      title: 'test',
    )));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
  });
  testWidgets('has Create button', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextButton, 'Create'), findsOneWidget);
  });
  testWidgets(' Create button works', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TextButton, 'Create'));
    expect(find.byType(Card), findsAtLeastNWidgets(1));
  });
}
