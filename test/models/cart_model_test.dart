import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart_model.dart';

void main() {
  group('CartItem Model Tests', () {
    test('should create a CartItem with all fields', () {
      final item = CartItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 2,
        color: 'Red',
        size: 'M',
        customText: 'Custom Text',
        imageUrl: 'https://example.com/image.jpg',
      );

      expect(item.id, 'test_001');
      expect(item.name, 'Test Product');
      expect(item.price, 19.99);
      expect(item.quantity, 2);
      expect(item.color, 'Red');
      expect(item.size, 'M');
      expect(item.customText, 'Custom Text');
      expect(item.imageUrl, 'https://example.com/image.jpg');
    });

    test('should create a CartItem with optional fields as null', () {
      final item = CartItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
      );

      expect(item.id, 'test_001');
      expect(item.name, 'Test Product');
      expect(item.price, 19.99);
      expect(item.quantity, 1);
      expect(item.color, isNull);
      expect(item.size, isNull);
      expect(item.customText, isNull);
      expect(item.imageUrl, isNull);
    });

    test('should allow mutable quantity', () {
      final item = CartItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
      );

      expect(item.quantity, 1);
      item.quantity = 5;
      expect(item.quantity, 5);
    });

    test('copyWith should create a new instance with updated values', () {
      final original = CartItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
        color: 'Red',
        size: 'M',
      );

      final updated = original.copyWith(
        quantity: 3,
        color: 'Blue',
      );

      // Original should be unchanged
      expect(original.quantity, 1);
      expect(original.color, 'Red');

      // Updated should have new values
      expect(updated.quantity, 3);
      expect(updated.color, 'Blue');

      // Other fields should remain the same
      expect(updated.id, original.id);
      expect(updated.name, original.name);
      expect(updated.price, original.price);
      expect(updated.size, original.size);
    });

    test('copyWith should preserve original values when not specified', () {
      final original = CartItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
        color: 'Red',
        size: 'M',
      );

      final updated = original.copyWith(quantity: 5);

      // Should keep original values for unspecified fields
      expect(updated.color, 'Red');
      expect(updated.size, 'M');
      expect(updated.id, original.id);
      expect(updated.quantity, 5);
    });

    test('should calculate correct total price', () {
      final item = CartItem(
        id: 'test_001',
        name: 'Test Product',
        price: 10.50,
        quantity: 3,
      );

      expect(item.price * item.quantity, 31.50);
    });
  });
}
