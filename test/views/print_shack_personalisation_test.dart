import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/print_shack_personalisation.dart';

void main() {
  group('PrintShackPersonalisationPage Tests', () {
    Widget createTestWidget() {
      return const MaterialApp(
        home: ProductPage(),
      );
    }

    void setupViewport(WidgetTester tester) {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    }

    testWidgets('should display page title', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Personalisation'), findsOneWidget);
    });

    testWidgets('should display personalisation dropdown', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Personalisation'), findsWidgets);
      // The dropdown shows the selected option, and 'Per Line:' label also contains this text
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    });

    testWidgets('should display initial price', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Initial price should be £3.00 for one line
      expect(find.text('£3.00'), findsOneWidget);
    });

    testWidgets('should display dropdown with options', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check dropdown displays current selection
      expect(find.byType(DropdownButton<String>), findsOneWidget);
    });

    testWidgets('should update price when selecting three lines',
        (tester) async {
      setupViewport(tester);
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Scroll to dropdown if needed
      await tester.ensureVisible(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Tap dropdown to open it
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Select three lines
      await tester.tap(find.text('Three Lines of Text').last);
      await tester.pumpAndSettle();

      // Price should update to £7.50
      expect(find.text('£7.50'), findsOneWidget);
    });

    testWidgets('should update price when selecting four lines',
        (tester) async {
      setupViewport(tester);
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Scroll to dropdown if needed
      await tester.ensureVisible(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Tap dropdown to open it
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Select four lines
      await tester.tap(find.text('Four Lines of Text').last);
      await tester.pumpAndSettle();

      // Price should update to £10.00
      expect(find.text('£10.00'), findsOneWidget);
    });

    testWidgets('should update price when selecting small logo',
        (tester) async {
      setupViewport(tester);
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Scroll to dropdown if needed
      await tester.ensureVisible(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Tap dropdown to open it
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Select small logo
      await tester.tap(find.text('Small logo(chest)').last);
      await tester.pumpAndSettle();

      // Price should update to £3.50
      expect(find.text('£3.50'), findsOneWidget);
    });

    testWidgets('should update price when selecting large logo',
        (tester) async {
      setupViewport(tester);
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Scroll to dropdown if needed
      await tester.ensureVisible(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Tap dropdown to open it
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Select large logo
      await tester.tap(find.text('Large logo(back)').last);
      await tester.pumpAndSettle();

      // Price should update to £6.00
      expect(find.text('£6.00'), findsOneWidget);
    });

    testWidgets('should show only one text field for one line', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Should show one personalisation TextFormField plus one for quantity (2 total)
      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('should show two text fields when two lines selected',
        (tester) async {
      setupViewport(tester);
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Scroll to dropdown if needed
      await tester.ensureVisible(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Tap dropdown to open it
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Two Lines of Text').last);
      await tester.pumpAndSettle();

      // Should show two personalisation TextFormFields plus one for quantity (3 total)
      expect(find.byType(TextFormField), findsNWidgets(3));
    });

    testWidgets('should multiply price by quantity', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Initial price is £3.00 with quantity 1
      expect(find.text('£3.00'), findsOneWidget);

      // Scroll to and tap the increment button
      await tester.ensureVisible(find.byIcon(Icons.arrow_drop_up));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_drop_up));
      await tester.pumpAndSettle();

      // Price should double to £6.00
      expect(find.text('£6.00'), findsOneWidget);
    });

    testWidgets('should not go below quantity 1', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Try to decrement below 1 - should stay at 1 (use .last to get quantity selector, not navbar)
      await tester.tap(find.byIcon(Icons.arrow_drop_down).last);
      await tester.pumpAndSettle();

      // Price should still be £3.00 (quantity 1)
      expect(find.text('£3.00'), findsOneWidget);
    });

    testWidgets('should display quantity selector', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Quantity'), findsOneWidget);
      // arrow_drop_down appears twice: navbar and quantity selector
      expect(find.byIcon(Icons.arrow_drop_down), findsNWidgets(2));
      expect(find.byIcon(Icons.arrow_drop_up), findsOneWidget);
      // Quantity is shown in a TextFormField
      expect(find.byType(TextFormField), findsWidgets);
    });

    testWidgets('should display add to cart button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Add to cart'), findsOneWidget);
    });

    testWidgets('should display back to personalisation button',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('BACK TO PERSONALISATION'), findsOneWidget);
    });

    testWidgets('should have text fields for personalisation', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check that text fields exist
      expect(find.byType(TextFormField), findsWidgets);
    });

    testWidgets('should have navbar and footer', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check navbar
      expect(find.byIcon(Icons.search), findsOneWidget);

      // Scroll to footer
      await tester.dragUntilVisible(
        find.text('Opening Hours'),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );
      expect(find.text('Opening Hours'), findsOneWidget);
    });

    testWidgets('should calculate correct total price with quantity',
        (tester) async {
      setupViewport(tester);
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Scroll to dropdown if needed
      await tester.ensureVisible(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Select three lines (£7.50)
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Three Lines of Text').last);
      await tester.pumpAndSettle();

      // Increase quantity to 2
      await tester.tap(find.byIcon(Icons.arrow_drop_up));
      await tester.pumpAndSettle();

      // Total should be £15.00 (£7.50 × 2)
      expect(find.text('£15.00'), findsOneWidget);
    });
  });
}
