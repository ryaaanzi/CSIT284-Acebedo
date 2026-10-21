
import 'package:flutter_test/flutter_test.dart';
import 'package:campus_wellness_tracker/app.dart';

void main() {
  testWidgets('Campus Wellness Tracker launches', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CampusWellnessApp());

    expect(find.text('Campus Wellness'), findsOneWidget);
    expect(find.text('Start Assessment'), findsOneWidget);
  });
}
