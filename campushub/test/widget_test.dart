
import 'package:flutter_test/flutter_test.dart';
import 'package:campushub/main.dart';

void main() {
  testWidgets('CampusHub app loads successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CampusHubApp());

    expect(find.byType(CampusHubApp), findsOneWidget);
  });
}
