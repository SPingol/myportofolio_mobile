import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  testWidgets('Home screen renders portfolio menu', (
    WidgetTester tester,
  ) async {
    // Build our app with an ApiClient instance and trigger a frame.
    await tester.pumpWidget(MyApp(apiClient: ApiClient()));

    // Verify that the home screen title, greeting, and menu cards are rendered.
    expect(find.text('MYPORTFOLIO'), findsOneWidget);
    expect(find.text('Welcome to MyPortfolio Mobile!'), findsOneWidget);
    expect(find.text('View Projects'), findsOneWidget);
    expect(find.text('Add Project'), findsOneWidget);
  });
}
