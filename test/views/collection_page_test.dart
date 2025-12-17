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

    testWidgets('should display actual product names and prices',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Should show first 9 products on page 1
      expect(find.text('Classic Hoodies'), findsOneWidget);
      expect(find.text('£25.00'), findsOneWidget);
      expect(find.text('Classic Sweatshirts'), findsOneWidget);
      expect(find.text('£23.00'), findsOneWidget);
      expect(find.text('Classic T-Shirts'), findsOneWidget);
      expect(find.text('£11.00'), findsOneWidget);
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

    testWidgets('should filter products by Clothing category', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Initially shows all 17 products
      expect(find.text('17 products'), findsOneWidget);

      // Tap filter dropdown
      final filterDropdown = find.ancestor(
        of: find.text('All products'),
        matching: find.byType(InkWell),
      );
      await tester.tap(filterDropdown.first);
      await tester.pumpAndSettle();

      // Select Clothing
      await tester.tap(find.text('Clothing').last);
      await tester.pumpAndSettle();

      // Should show 14 clothing products
      expect(find.text('14 products'), findsOneWidget);
    });

    testWidgets('should filter products by Merchandise category',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Tap filter dropdown
      final filterDropdown = find.ancestor(
        of: find.text('All products'),
        matching: find.byType(InkWell),
      );
      await tester.tap(filterDropdown.first);
      await tester.pumpAndSettle();

      // Select Merchandise
      await tester.tap(find.text('Merchandise'));
      await tester.pumpAndSettle();

      // Should show 3 merchandise products
      expect(find.text('3 products'), findsOneWidget);
      expect(find.text('Classic Cap'), findsOneWidget);
      expect(find.text('Classic Beanie Hat'), findsOneWidget);
      expect(find.text('Limited Edition UoP Beanies'), findsOneWidget);
    });

    testWidgets('should sort products alphabetically A-Z', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Tap sort dropdown
      final sortDropdown = find.ancestor(
        of: find.text('Featured'),
        matching: find.byType(InkWell),
      );
      await tester.tap(sortDropdown.first);
      await tester.pumpAndSettle();

      // Select Alphabetically, A-Z
      await tester.tap(find.text('Alphabetically, A–Z'));
      await tester.pumpAndSettle();

      // First product should now be "Classic Beanie Hat"
      expect(find.text('Classic Beanie Hat'), findsOneWidget);
    });

    testWidgets('should sort products alphabetically Z-A', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Tap sort dropdown
      final sortDropdown = find.ancestor(
        of: find.text('Featured'),
        matching: find.byType(InkWell),
      );
      await tester.tap(sortDropdown.first);
      await tester.pumpAndSettle();

      // Select Alphabetically, Z-A
      await tester.tap(find.text('Alphabetically, Z–A'));
      await tester.pumpAndSettle();

      // First product should now be "Waterproof Poncho"
      expect(find.text('Waterproof Poncho'), findsOneWidget);
    });

    testWidgets('should sort products by price low to high', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Tap sort dropdown
      final sortDropdown = find.ancestor(
        of: find.text('Featured'),
        matching: find.byType(InkWell),
      );
      await tester.tap(sortDropdown.first);
      await tester.pumpAndSettle();

      // Select Price, low to high
      await tester.tap(find.text('Price, low to high'));
      await tester.pumpAndSettle();

      // First product should be Waterproof Poncho (£1.99)
      expect(find.text('Waterproof Poncho'), findsOneWidget);
      expect(find.text('£1.99'), findsOneWidget);
    });

    testWidgets('should sort products by price high to low', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Tap sort dropdown
      final sortDropdown = find.ancestor(
        of: find.text('Featured'),
        matching: find.byType(InkWell),
      );
      await tester.tap(sortDropdown.first);
      await tester.pumpAndSettle();

      // Select Price, high to low
      await tester.tap(find.text('Price, high to low'));
      await tester.pumpAndSettle();

      // First product should be Graduation 3/4 Zipped Sweatshirt (£45.00)
      expect(find.text('Graduation 3/4 Zipped Sweatshirt'), findsOneWidget);
      expect(find.text('£45.00'), findsOneWidget);
    });

    testWidgets('should reset to page 1 when filter changes', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Navigate to page 2
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -1000));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();
      expect(find.text('Page 2 of 2'), findsOneWidget);

      // Scroll back up to filter dropdown
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, 1000));
      await tester.pumpAndSettle();

      // Change filter
      final filterDropdown = find.ancestor(
        of: find.text('All products'),
        matching: find.byType(InkWell),
      );
      await tester.tap(filterDropdown.first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Merchandise'));
      await tester.pumpAndSettle();

      // Should be back on page 1
      // With only 3 merchandise items, pagination should be hidden
      expect(find.text('Page 1 of 1'), findsNothing);
      expect(find.byIcon(Icons.arrow_forward), findsNothing);
    });

    testWidgets('should reset to page 1 when sort changes', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Navigate to page 2
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -1000));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();
      expect(find.text('Page 2 of 2'), findsOneWidget);

      // Scroll back up to sort dropdown
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, 1000));
      await tester.pumpAndSettle();

      // Change sort
      final sortDropdown = find.ancestor(
        of: find.text('Featured'),
        matching: find.byType(InkWell),
      );
      await tester.tap(sortDropdown.first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Price, low to high'));
      await tester.pumpAndSettle();

      // Should be back on page 1
      expect(find.text('Page 1 of 2'), findsOneWidget);
    });

    testWidgets('should hide pagination when only one page', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Filter to Merchandise (only 3 items)
      final filterDropdown = find.ancestor(
        of: find.text('All products'),
        matching: find.byType(InkWell),
      );
      await tester.tap(filterDropdown.first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Merchandise'));
      await tester.pumpAndSettle();

      // Pagination should be hidden
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -1000));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.arrow_forward), findsNothing);
      expect(find.byIcon(Icons.arrow_back), findsNothing);
    });

    testWidgets('should display correct product count after filtering',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Initially 17 products
      expect(find.text('17 products'), findsOneWidget);

      // Filter to Clothing
      final filterDropdown = find.ancestor(
        of: find.text('All products'),
        matching: find.byType(InkWell),
      );
      await tester.tap(filterDropdown.first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Clothing').last);
      await tester.pumpAndSettle();

      // Should show 14 products
      expect(find.text('14 products'), findsOneWidget);
    });

    testWidgets('should navigate to product page when product tapped',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;

      final navigatorKey = GlobalKey<NavigatorState>();
      await tester.pumpWidget(MaterialApp(
        navigatorKey: navigatorKey,
        home: const CollectionPage(),
        routes: {
          '/product': (context) => const Scaffold(body: Text('Product Page')),
        },
      ));
      await tester.pumpAndSettle();

      // Tap on first product
      await tester.tap(find.text('Classic Hoodies'));
      await tester.pumpAndSettle();

      // Should navigate to product page
      expect(find.text('Product Page'), findsOneWidget);
    });
  });
}
