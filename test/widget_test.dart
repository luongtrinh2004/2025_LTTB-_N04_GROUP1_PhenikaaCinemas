// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_cinema_booking_ui/main.dart';

void main() {
  testWidgets('App builds without errors', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const CinemaApp());

    // Verify that the app contains a MaterialApp by finding a widget with
    // the title text specified in the app (optional) or simply ensure no
    // exceptions occurred during build by pumping one frame.
    await tester.pumpAndSettle();
    expect(find.byType(Navigator), findsOneWidget);
  });
}
