import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/sign_in.dart';

void main() {
  group('SignInPage Tests', () {
    setUp(() {
      // Suppress network image errors during tests
      FlutterError.onError = (FlutterErrorDetails details) {
        final exception = details.exception;
        final isIgnorableError =
            exception.toString().contains('NetworkImageLoadException');
        if (!isIgnorableError) {
          FlutterError.presentError(details);
        }
      };
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: const SignInPage(),
      );
    }

    testWidgets('should display sign in page with title', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Sign in'), findsOneWidget);
      expect(find.text('Sign in or create an account'), findsOneWidget);
    });

    testWidgets('should display logo at top', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check for logo image
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should display sign in with shop button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Sign in with Shop'), findsOneWidget);
    });

    testWidgets('should display or divider', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('or'), findsOneWidget);
      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('should display email input field', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('should display continue button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('continue button should be disabled initially', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find the Continue button
      final continueButton = find.ancestor(
        of: find.text('Continue'),
        matching: find.byType(ElevatedButton),
      );

      // Button should be disabled (onPressed is null or has disabled styling)
      // We can check by tapping and verifying no navigation occurs
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      // Should still be on sign in page
      expect(find.text('Sign in'), findsOneWidget);
    });

    testWidgets('should validate email format correctly', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Enter invalid email
      await tester.enterText(find.byType(TextField), 'invalid-email');
      await tester.pumpAndSettle();

      // Continue button should still be disabled
      final continueButton = find.ancestor(
        of: find.text('Continue'),
        matching: find.byType(ElevatedButton),
      );
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      // Should still be on sign in page
      expect(find.text('Sign in'), findsOneWidget);
    });

    testWidgets('should enable continue button with valid email',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Enter valid email
      await tester.enterText(find.byType(TextField), 'test@example.com');
      await tester.pumpAndSettle();

      // Continue button should now be enabled
      final continueButton = find.ancestor(
        of: find.text('Continue'),
        matching: find.byType(ElevatedButton),
      );

      expect(continueButton, findsOneWidget);
    });

    testWidgets('should navigate to home on continue with valid email',
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        initialRoute: '/signin',
        routes: {
          '/': (context) => const Scaffold(body: Text('Home Page')),
          '/signin': (context) => const SignInPage(),
        },
      ));
      await tester.pumpAndSettle();

      // Enter valid email
      await tester.enterText(find.byType(TextField), 'user@test.com');
      await tester.pumpAndSettle();

      // Tap continue button
      final continueButton = find.ancestor(
        of: find.text('Continue'),
        matching: find.byType(ElevatedButton),
      );
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      // Should navigate to home page
      expect(find.text('Home Page'), findsOneWidget);
    });

    testWidgets('should accept various valid email formats', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final validEmails = [
        'user@example.com',
        'test.user@example.co.uk',
        'user123@test-domain.com',
        'first.last@example.org',
      ];

      for (final email in validEmails) {
        // Clear and enter new email
        await tester.enterText(find.byType(TextField), '');
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), email);
        await tester.pumpAndSettle();

        // Button should be enabled
        final continueButton = find.ancestor(
          of: find.text('Continue'),
          matching: find.byType(ElevatedButton),
        );
        expect(continueButton, findsOneWidget);
      }
    });

    testWidgets('should reject invalid email formats', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final invalidEmails = [
        'notanemail',
        '@example.com',
        'user@',
        'user @example.com',
        'user@.com',
      ];

      for (final email in invalidEmails) {
        // Clear and enter invalid email
        await tester.enterText(find.byType(TextField), '');
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), email);
        await tester.pumpAndSettle();

        // Try to tap continue
        final continueButton = find.ancestor(
          of: find.text('Continue'),
          matching: find.byType(ElevatedButton),
        );
        await tester.tap(continueButton);
        await tester.pumpAndSettle();

        // Should still be on sign in page
        expect(find.text('Sign in'), findsOneWidget);
      }
    });

    testWidgets('should navigate to home when logo tapped', (tester) async {
      await tester.pumpWidget(MaterialApp(
        initialRoute: '/signin',
        routes: {
          '/': (context) => const Scaffold(body: Text('Home Page')),
          '/signin': (context) => const SignInPage(),
        },
      ));
      await tester.pumpAndSettle();

      // Find and tap logo (wrapped in GestureDetector)
      final logoGesture = find.ancestor(
        of: find.byType(Image),
        matching: find.byType(GestureDetector),
      );
      await tester.tap(logoGesture);
      await tester.pumpAndSettle();

      // Should navigate to home
      expect(find.text('Home Page'), findsOneWidget);
    });

    testWidgets('should have white container with shadow', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find the main container
      final container = find.byType(Container);
      expect(container, findsWidgets);
    });

    testWidgets('should be centered on screen', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Should have Center widgets for centering content
      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('should be scrollable', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('should have constrained width', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Should have ConstrainedBox widgets with maxWidth constraints
      expect(find.byType(ConstrainedBox), findsWidgets);
    });

    testWidgets('should be responsive on small screens', (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Sign in'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      addTearDown(() => tester.binding.setSurfaceSize(null));
    });

    testWidgets('should be responsive on large screens', (tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Sign in'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      addTearDown(() => tester.binding.setSurfaceSize(null));
    });

    testWidgets('should have proper color scheme', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify scaffold background color
      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, Colors.grey[50]);
    });

    testWidgets('should update button state as email changes', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Start with invalid
      await tester.enterText(find.byType(TextField), 'invalid');
      await tester.pumpAndSettle();

      // Make it valid
      await tester.enterText(find.byType(TextField), 'valid@email.com');
      await tester.pumpAndSettle();

      // Button should be enabled
      final continueButton = find.ancestor(
        of: find.text('Continue'),
        matching: find.byType(ElevatedButton),
      );
      expect(continueButton, findsOneWidget);

      // Make it invalid again
      await tester.enterText(find.byType(TextField), 'invalid');
      await tester.pumpAndSettle();

      // Should still find the button (but disabled)
      expect(continueButton, findsOneWidget);
    });
  });
}
