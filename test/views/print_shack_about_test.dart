import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/print_shack_about.dart';
import 'package:union_shop/widgets/app_footer.dart';

void main() {
  group('PrintShackAboutPage Tests', () {
    Widget createTestWidget() {
      return const MaterialApp(
        home: PrintShackPage(),
      );
    }

    testWidgets('should display page title', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('The Union Print Shack'), findsOneWidget);
    });

    testWidgets('should display main heading', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(
        find.text('Make It Yours at The Union Print Shack'),
        findsOneWidget,
      );
    });

    testWidgets('should display customisation description', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(
        find.textContaining(
            'Want to add a personal touch? We\'ve got you covered with heat-pressed customisation'),
        findsOneWidget,
      );
    });

    testWidgets('should display pricing information', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Simple Pricing, No Surprises'), findsOneWidget);
    });

    testWidgets('should display logo image', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check for Image.network widget
      expect(find.byType(Image), findsWidgets);
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

    testWidgets('should have centered content', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check for ConstrainedBox with maxWidth constraint
      final constrainedBox = find.byType(ConstrainedBox);
      expect(constrainedBox, findsWidgets);
    });
  });
}
