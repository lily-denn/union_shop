import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/cart_page.dart';
import 'package:union_shop/widgets/app_footer.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CartPage Tests', () {
    setUp(() {
      // Suppress overflow and network image errors
      FlutterError.onError = (details) {
        final exception = details.exception;
        final message = exception.toString();
        // Silently ignore overflow errors and network image errors
        if (message.contains('overflowed') ||
            message.contains('RenderFlex overflowed') ||
            (exception is FlutterError &&
                exception.diagnostics.any(
                    (node) => node.value.toString().contains('overflowed')))) {
          return;
        }
        // Report other errors normally
        FlutterError.presentError(details);
      };
    });

    tearDown(() {
      // Reset to default error handler
      FlutterError.onError = FlutterError.presentError;
    });

    Widget createTestWidget({Size? screenSize}) {
      if (screenSize != null) {
        return MaterialApp(
          home: Builder(
            builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(size: screenSize),
                child: const CartPage(),
              );
            },
          ),
        );
      }
      return const MaterialApp(
        home: CartPage(),
      );
    }

    testWidgets('should display cart page', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(CartPage), findsOneWidget);
    });

    testWidgets('should display page title "Your cart"', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.text('Your cart'), findsOneWidget);
    });

    testWidgets('should display "Continue shopping" button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.text('Continue shopping'), findsOneWidget);
    });

    testWidgets('should display cart items', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check for sample cart items
      expect(find.text('Limited Edition Essential Zip Hoodie'), findsOneWidget);
      expect(find.text('Classic T-Shirt'), findsOneWidget);
    });

    testWidgets('should display product details (color and size)',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check for color and size display
      expect(find.textContaining('Color:'), findsWidgets);
      expect(find.textContaining('Size:'), findsWidgets);
    });

    testWidgets('should display prices', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Check for price formatting
      expect(find.textContaining('£'), findsWidgets);
    });

    testWidgets('should display subtotal', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.text('Subtotal'), findsOneWidget);
      expect(find.textContaining('£'), findsWidgets);
    });

    testWidgets('should display "CHECKOUT" button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.text('CHECKOUT'), findsOneWidget);
    });

    testWidgets('should have footer', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      expect(find.byType(AppFooter), findsOneWidget);
    });

    group('Desktop Layout Tests', () {
      testWidgets('should display desktop layout on wide screen',
          (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Desktop should show column headers
        expect(find.text('PRODUCT'), findsOneWidget);
        expect(find.text('PRICE'), findsOneWidget);
        expect(find.text('QUANTITY'), findsOneWidget);
        expect(find.text('TOTAL'), findsOneWidget);

        addTearDown(() => tester.view.resetPhysicalSize());
      });

      testWidgets('should display Remove button on desktop', (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Desktop should show Remove buttons
        expect(find.text('Remove'), findsWidgets);

        addTearDown(() => tester.view.resetPhysicalSize());
      });

      testWidgets('should display quantity controls on desktop',
          (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Desktop should show quantity input fields
        expect(find.byType(TextFormField), findsWidgets);
        // Should have arrow controls
        expect(find.byIcon(Icons.arrow_drop_up), findsWidgets);
        expect(find.byIcon(Icons.arrow_drop_down), findsWidgets);

        addTearDown(() => tester.view.resetPhysicalSize());
      });

      testWidgets('should increment quantity when up arrow is tapped',
          (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Find first quantity field
        final quantityFields = find.byType(TextFormField);
        expect(quantityFields, findsWidgets);

        // Get initial quantity value
        final firstField = tester.widget<TextFormField>(quantityFields.first);
        final initialValue = firstField.controller?.text;

        // Tap up arrow for first item
        final upArrows = find.byIcon(Icons.arrow_drop_up);
        await tester.tap(upArrows.first);
        await tester.pump();

        // Quantity should have increased
        final updatedField = tester.widget<TextFormField>(quantityFields.first);
        final newValue = updatedField.controller?.text;

        expect(int.parse(newValue ?? '0'),
            greaterThan(int.parse(initialValue ?? '0')));

        addTearDown(() => tester.view.resetPhysicalSize());
      });

      testWidgets('should decrement quantity when down arrow is tapped',
          (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // First, increment quantity to make sure it's > 1
        final upArrows = find.byIcon(Icons.arrow_drop_up);
        await tester.tap(upArrows.first);
        await tester.pump();

        // Get quantity value
        final quantityFields = find.byType(TextFormField);
        final fieldBeforeDecrement =
            tester.widget<TextFormField>(quantityFields.first);
        final valueBeforeDecrement = fieldBeforeDecrement.controller?.text;

        // Tap down arrow
        final downArrows = find.byIcon(Icons.arrow_drop_down);
        await tester.tap(downArrows.first);
        await tester.pump();

        // Quantity should have decreased
        final fieldAfterDecrement =
            tester.widget<TextFormField>(quantityFields.first);
        final valueAfterDecrement = fieldAfterDecrement.controller?.text;

        expect(int.parse(valueAfterDecrement ?? '0'),
            lessThan(int.parse(valueBeforeDecrement ?? '0')));

        addTearDown(() => tester.view.resetPhysicalSize());
      });

      testWidgets('should remove item when Remove button is tapped',
          (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Check initial cart items count
        expect(
            find.text('Limited Edition Essential Zip Hoodie'), findsOneWidget);

        // Tap first Remove button
        final removeButtons = find.text('Remove');
        await tester.tap(removeButtons.first);
        await tester.pump();

        // Item should be removed
        expect(find.text('Limited Edition Essential Zip Hoodie'), findsNothing);

        addTearDown(() => tester.view.resetPhysicalSize());
      });

      testWidgets('should validate quantity input and revert invalid entries',
          (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Find first quantity field
        final quantityFields = find.byType(TextFormField);
        final firstField = tester.widget<TextFormField>(quantityFields.first);
        final initialValue = firstField.controller?.text;

        // Enter invalid text
        await tester.enterText(quantityFields.first, 'abc');
        await tester.pump();

        // Should revert to previous valid value
        final updatedField = tester.widget<TextFormField>(quantityFields.first);
        final revertedValue = updatedField.controller?.text;

        expect(revertedValue, equals(initialValue));

        addTearDown(() => tester.view.resetPhysicalSize());
      });
    });

    group('Mobile Layout Tests', () {
      testWidgets('should display mobile layout with Edit buttons',
          (tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Mobile layout should show Edit buttons (one per cart item)
        expect(find.text('Edit'), findsWidgets);

        addTearDown(() => tester.view.resetPhysicalSize());
      });

      testWidgets('should display Edit buttons on mobile', (tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Mobile should show Edit buttons
        expect(find.text('Edit'), findsWidgets);

        addTearDown(() => tester.view.resetPhysicalSize());
      });

      testWidgets('should show editing section when Edit is tapped',
          (tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Initially, Update button should not be visible
        expect(find.text('Update'), findsNothing);

        // Tap Edit button
        final editButtons = find.text('Edit');
        await tester.tap(editButtons.first);
        await tester.pump();

        // Edit button should change to Cancel
        expect(find.text('Cancel'), findsWidgets);
        // Editing section should appear with Update button
        expect(find.text('Update'), findsWidgets);
        // Should show Remove option
        expect(find.text('Remove'), findsWidgets);

        addTearDown(() => tester.view.resetPhysicalSize());
      });

      testWidgets('should hide editing section when Cancel is tapped',
          (tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Tap Edit button
        final editButtons = find.text('Edit');
        await tester.tap(editButtons.first);
        await tester.pump();

        // Editing section should be visible
        expect(find.text('Update'), findsWidgets);

        // Tap Cancel button
        final cancelButtons = find.text('Cancel');
        await tester.tap(cancelButtons.first);
        await tester.pump();

        // Editing section should be hidden
        expect(find.text('Update'), findsNothing);
        expect(find.text('Edit'), findsWidgets);

        addTearDown(() => tester.view.resetPhysicalSize());
      });

      testWidgets('should display quantity controls in editing section',
          (tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Tap Edit button
        final editButtons = find.text('Edit');
        await tester.tap(editButtons.first);
        await tester.pump();

        // Should show Quantity label and controls
        expect(find.text('Quantity'), findsWidgets);
        expect(find.byType(TextFormField), findsWidgets);
        expect(find.byIcon(Icons.arrow_drop_up), findsWidgets);
        expect(find.byIcon(Icons.arrow_drop_down), findsWidgets);

        addTearDown(() => tester.view.resetPhysicalSize());
      });

      testWidgets(
          'should increment quantity in mobile editing section when up arrow is tapped',
          (tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Tap Edit to show editing section
        final editButtons = find.text('Edit');
        await tester.tap(editButtons.first);
        await tester.pump();

        // Get initial quantity
        final quantityFields = find.byType(TextFormField);
        final initialField = tester.widget<TextFormField>(quantityFields.first);
        final initialValue = initialField.controller?.text;

        // Tap up arrow
        final upArrows = find.byIcon(Icons.arrow_drop_up);
        await tester.tap(upArrows.first);
        await tester.pump();

        // Quantity should increase
        final updatedField = tester.widget<TextFormField>(quantityFields.first);
        final newValue = updatedField.controller?.text;

        expect(int.parse(newValue ?? '0'),
            greaterThan(int.parse(initialValue ?? '0')));

        addTearDown(() => tester.view.resetPhysicalSize());
      });

      testWidgets('should close editing section when Update is tapped',
          (tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Tap Edit button
        final editButtons = find.text('Edit');
        await tester.tap(editButtons.first);
        await tester.pump();

        // Editing section should be visible
        expect(find.text('Update'), findsWidgets);

        // Tap Update button
        final updateButtons = find.text('Update');
        await tester.tap(updateButtons.first);
        await tester.pump();

        // Editing section should close
        expect(find.text('Update'), findsNothing);
        expect(find.text('Edit'), findsWidgets);

        addTearDown(() => tester.view.resetPhysicalSize());
      });

      testWidgets('should remove item when Remove is tapped in editing section',
          (tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Verify item exists
        expect(
            find.text('Limited Edition Essential Zip Hoodie'), findsOneWidget);

        // Tap Edit button
        final editButtons = find.text('Edit');
        await tester.tap(editButtons.first);
        await tester.pump();

        // Tap Remove button in editing section
        final removeButtons = find.text('Remove');
        await tester.tap(removeButtons.first);
        await tester.pump();

        // Item should be removed
        expect(find.text('Limited Edition Essential Zip Hoodie'), findsNothing);

        addTearDown(() => tester.view.resetPhysicalSize());
      });
    });

    group('Subtotal Calculation Tests', () {
      testWidgets('should calculate correct subtotal', (tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Initial cart has:
        // Item 1: £14.99 × 1 = £14.99
        // Item 2: £9.99 × 2 = £19.98
        // Subtotal should be £34.97

        expect(find.text('£34.97'), findsOneWidget);
      });

      testWidgets('should update subtotal when quantity changes',
          (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Initial subtotal
        expect(find.text('£34.97'), findsOneWidget);

        // Increment first item quantity
        final upArrows = find.byIcon(Icons.arrow_drop_up);
        await tester.tap(upArrows.first);
        await tester.pump();

        // Subtotal should increase by £14.99 to £49.96
        expect(find.text('£49.96'), findsOneWidget);

        addTearDown(() => tester.view.resetPhysicalSize());
      });

      testWidgets('should update subtotal when item is removed',
          (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Initial subtotal
        expect(find.text('£34.97'), findsOneWidget);

        // Remove first item (£14.99 × 1)
        final removeButtons = find.text('Remove');
        await tester.tap(removeButtons.first);
        await tester.pump();

        // Subtotal should be £19.98 (only second item remains)
        // Note: Price appears in both item row and subtotal section
        expect(find.text('£19.98'), findsWidgets);

        addTearDown(() => tester.view.resetPhysicalSize());
      });
    });

    group('Note Section Tests', () {
      testWidgets('should display note section', (tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        expect(find.text('Add a note to your order'), findsOneWidget);
      });

      testWidgets('should have text input for notes', (tester) async {
        await tester.pumpWidget(createTestWidget());
        await tester.pump();

        // Look for TextFormField in note section
        expect(find.byType(TextFormField), findsWidgets);
      });
    });
  });
}
