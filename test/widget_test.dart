import 'package:belegscanner_mvp/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Placeholder app builds', (tester) async {
    await tester.pumpWidget(const BelegscannerApp());
    expect(find.text('Belegscanner MVP'), findsOneWidget);
  });
}
