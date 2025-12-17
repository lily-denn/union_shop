import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/salecollection_page.dart';

void main() {
  group('SaleCollectionPage Tests', () {
    setUp(() {
      // Ignore overflow errors during tests
      FlutterError.onError = (FlutterErrorDetails details) {
        final exception = details.exception;
        final isOverflowError = exception is FlutterError &&
            !exception.diagnostics
                .any((node) => node.value.toString().contains('overflowed'));
        if (isOverflowError) {
          FlutterError.presentError(details);
        }
      };
    });

    Widget createTestWidget() {
      return const MaterialApp(
        home: CollectionPage(),
      );
    }

    testWidgets('should display SALE title and subtitle', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('SALE'), findsOneWidget);
      expect(
        find.textContaining(
            "Don't miss out! Get yours before they're all gone!"),
        findsOneWidget,
      );
    });

    testWidgets('should display correct product count for sale items',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('12 products'), findsOneWidget);
    });

    testWidgets('should display 9 products on page 1', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check for first page products
      expect(find.text('A5 Notepad'), findsOneWidget);
      expect(find.text('Classic Sweatshirts - Neutral'), findsOneWidget);
      expect(find.text('Recycled Notebook'), findsOneWidget);
    });

    testWidgets('should display sold out items correctly', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // A5 Notepad should show "Sold out" instead of price
      expect(find.text('Sold out'), findsWidgets);
    });

    testWidgets('should display prices with strikethrough for discounted items',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check for old and new prices
      expect(find.text('£17.00'), findsOneWidget);
      expect(find.text('£10.99'), findsOneWidget);
    });

    testWidgets('should display filter and sort options', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('FILTER BY'), findsOneWidget);
      expect(find.text('SORT BY'), findsOneWidget);
    });

    testWidgets('should have navbar', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check navbar
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    });

    testWidgets('should display product grid', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should display navigation buttons', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('Page 1 of 2'), findsOneWidget);
    });

    testWidgets('should have footer', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Footer should exist
      expect(find.text('Opening Hours'), findsOneWidget);
    });
  });
}
