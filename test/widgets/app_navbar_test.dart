import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/app_navbar.dart';

void main() {
  group('AppNavbar Tests', () {
    Widget createTestWidget() {
      return const MaterialApp(
        home: Scaffold(
          body: AppNavbar(),
        ),
      );
    }

    testWidgets('should display top banner with sale message', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(
        find.textContaining(
            'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE!'),
        findsOneWidget,
      );
    });

    testWidgets('should display logo image', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should display search icon', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should display person icon', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });

    testWidgets('should display shopping bag icon', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    });

    testWidgets('should display menu icon on small screens', (tester) async {
      await tester.binding.setSurfaceSize(const Size(500, 800));
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.menu), findsOneWidget);

      addTearDown(() => tester.binding.setSurfaceSize(null));
    });

    testWidgets('should display navigation links on large screens',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Navbar shows links on screens >= 900px
      // Check for TextButtons (the navigation links)
      expect(find.byType(TextButton), findsWidgets);
      // Or check that menu icon is NOT shown on large screens
      expect(find.byIcon(Icons.menu), findsNothing);
      expect(find.text('UPSU.net'), findsOneWidget);

      addTearDown(() => tester.binding.setSurfaceSize(null));
    });

    testWidgets('should have responsive design', (tester) async {
      // Test on small screen
      await tester.binding.setSurfaceSize(const Size(500, 800));
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsOneWidget);

      // Test on large screen
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsOneWidget);

      addTearDown(() => tester.binding.setSurfaceSize(null));
    });
  });
}
