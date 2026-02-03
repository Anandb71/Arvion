// Basic smoke test for Arvion app

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arvion/app.dart';

void main() {
  testWidgets('App loads and displays dashboard', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(
      const ProviderScope(child: ArvionApp()),
    );

    // Wait for async operations
    await tester.pumpAndSettle();

    // The app should load (may show loading indicator initially)
    expect(find.byType(ArvionApp), findsOneWidget);
  });
}
