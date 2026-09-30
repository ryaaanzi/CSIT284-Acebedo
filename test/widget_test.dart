import 'package:flutter_test/flutter_test.dart';

import 'package:csit284_acebedo/main.dart';

void main() {
  testWidgets('Favorite Food Finder loads', (WidgetTester tester) async {
    await tester.pumpWidget(const FoodFinderApp());

    expect(find.text('Favorite Food Finder'), findsOneWidget);
    expect(find.text('START'), findsOneWidget);
  });
}