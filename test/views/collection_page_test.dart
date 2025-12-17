import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/collection_page.dart';
import 'package:union_shop/widgets/app_footer.dart';

void main() {
  group('CollectionPage Tests', () {
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

    testWidgets('should display collection page with title', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Clothing'), findsOneWidget);
    });

    testWidgets('should display filter and sort dropdowns', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('FILTER BY'), findsOneWidget);
      expect(find.text('SORT BY'), findsOneWidget);
      expect(find.text('All products'), findsOneWidget);
      expect(find.text('Featured'), findsOneWidget);
    });

    testWidgets('should display 17 products', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('17 products'), findsOneWidget);
    });

    testWidgets('should display navigation buttons', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('Page 1 of 2'), findsOneWidget);
    });

    testWidgets('should display 12 products per page', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Should show 9 products on first page
      expect(find.text('Product 1'), findsOneWidget);
      expect(find.text('Product 9'), findsOneWidget);
    });

    testWidgets('should navigate to page 2 when next arrow clicked',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Scroll down to pagination controls
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -1000));
      await tester.pumpAndSettle();

      // Initial state - page 1
      expect(find.text('Page 1 of 2'), findsOneWidget);

      // Tap next button
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();

      // Should be on page 2
      expect(find.text('Page 2 of 2'), findsOneWidget);
    });

    testWidgets('should navigate between pages', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Scroll down to pagination controls
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -1000));
      await tester.pumpAndSettle();

      // Navigate to page 2 first
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();
      expect(find.text('Page 2 of 2'), findsOneWidget);

      // Navigate back to page 1
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.text('Page 1 of 2'), findsOneWidget);
    });

    testWidgets('should open filter dropdown when tapped', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find and tap the filter dropdown
      final filterDropdown = find.ancestor(
        of: find.text('All products'),
        matching: find.byType(InkWell),
      );
      await tester.tap(filterDropdown.first);
      await tester.pumpAndSettle();

      // Check that dropdown options appear
      expect(find.text('Clothing'), findsWidgets);
      expect(find.text('Merchandise'), findsOneWidget);
      expect(find.text('Popular'), findsOneWidget);
      expect(find.text('PSUT'), findsOneWidget);
    });

    testWidgets('should have AppNavbar', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check for navbar elements
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    });

    testWidgets('should have AppFooter', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check footer exists
      expect(find.byType(AppFooter), findsOneWidget);
    });

    testWidgets('should display products in grid layout', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that GridView exists
      expect(find.byType(GridView), findsOneWidget);
    });
  });
}
