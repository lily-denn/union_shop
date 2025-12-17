import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/about_page.dart';
import 'package:union_shop/widgets/app_footer.dart';

void main() {
  group('AboutPage Tests', () {
    Widget createTestWidget() {
      return const MaterialApp(
        home: AboutPage(),
      );
    }

    testWidgets('should display About Us title', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('About Us'), findsOneWidget);
    });

    testWidgets('should display welcome message', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Welcome to the Union Shop!'), findsOneWidget);
    });

    testWidgets('should display main description text', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(
        find.textContaining(
            'We\'re dedicated to giving you the very best University branded products'),
        findsOneWidget,
      );
    });

    testWidgets('should display delivery information', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(
        find.textContaining(
            'All online purchases are available for delivery or instore collection!'),
        findsOneWidget,
      );
    });

    testWidgets('should display contact information', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.textContaining('hello@upsu.net'), findsOneWidget);
    });

    testWidgets('should have navbar', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    });

    testWidgets('should have footer', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check footer exists
      expect(find.byType(AppFooter), findsOneWidget);
    });

    testWidgets('should be scrollable', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('should have divider below navbar', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final containers = find.byType(Container);
      bool foundDivider = false;

      for (int i = 0; i < containers.evaluate().length; i++) {
        final container = tester.widget<Container>(containers.at(i));
        if (container.constraints?.maxHeight == 1) {
          foundDivider = true;
          break;
        }
      }

      expect(foundDivider, true);
    });
  });
}
