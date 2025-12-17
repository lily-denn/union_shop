import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/models/cart_model.dart';

void main() {
  group('CartService Tests', () {
    late CartService cartService;

    setUp(() {
      cartService = CartService();
      // Clear any existing items
      cartService.clearCart();
    });

    tearDown(() {
      cartService.clearCart();
    });

    test('should start with empty cart', () {
      expect(cartService.items, isEmpty);
      expect(cartService.itemCount, 0);
      expect(cartService.subtotal, 0.0);
    });

    test('should add item to cart', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
      );

      expect(cartService.items.length, 1);
      expect(cartService.items.first.name, 'Test Product');
      expect(cartService.itemCount, 1);
    });

    test('should add item with all optional fields', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 2,
        color: 'Red',
        size: 'M',
        customText: 'Custom',
        imageUrl: 'https://example.com/image.jpg',
      );

      expect(cartService.items.length, 1);
      final item = cartService.items.first;
      expect(item.color, 'Red');
      expect(item.size, 'M');
      expect(item.customText, 'Custom');
      expect(item.imageUrl, 'https://example.com/image.jpg');
      expect(cartService.itemCount, 2);
    });

    test('should increment quantity for duplicate items', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
        color: 'Red',
        size: 'M',
      );

      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 2,
        color: 'Red',
        size: 'M',
      );

      expect(cartService.items.length, 1);
      expect(cartService.items.first.quantity, 3);
      expect(cartService.itemCount, 3);
    });

    test('should treat items with different colors as separate', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
        color: 'Red',
        size: 'M',
      );

      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
        color: 'Blue',
        size: 'M',
      );

      expect(cartService.items.length, 2);
      expect(cartService.itemCount, 2);
    });

    test('should treat items with different sizes as separate', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
        color: 'Red',
        size: 'M',
      );

      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
        color: 'Red',
        size: 'L',
      );

      expect(cartService.items.length, 2);
      expect(cartService.itemCount, 2);
    });

    test('should treat items with different customText as separate', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Custom Print',
        price: 5.00,
        quantity: 1,
        customText: 'Text 1',
      );

      cartService.addItem(
        id: 'test_001',
        name: 'Custom Print',
        price: 5.00,
        quantity: 1,
        customText: 'Text 2',
      );

      expect(cartService.items.length, 2);
      expect(cartService.itemCount, 2);
    });

    test('should update quantity for an existing item', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
      );

      final item = cartService.items.first;
      cartService.updateQuantity(item, 5);

      expect(cartService.items.first.quantity, 5);
      expect(cartService.itemCount, 5);
    });

    test('should not update quantity to zero or negative', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 2,
      );

      final item = cartService.items.first;
      cartService.updateQuantity(item, 0);

      // Quantity should remain unchanged
      expect(cartService.items.first.quantity, 2);

      cartService.updateQuantity(item, -1);
      expect(cartService.items.first.quantity, 2);
    });

    test('should remove item from cart', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product 1',
        price: 19.99,
        quantity: 1,
      );

      cartService.addItem(
        id: 'test_002',
        name: 'Test Product 2',
        price: 9.99,
        quantity: 1,
      );

      expect(cartService.items.length, 2);

      final itemToRemove = cartService.items.first;
      cartService.removeItem(itemToRemove);

      expect(cartService.items.length, 1);
      expect(cartService.items.first.id, 'test_002');
    });

    test('should remove item by id', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product 1',
        price: 19.99,
        quantity: 1,
      );

      cartService.addItem(
        id: 'test_002',
        name: 'Test Product 2',
        price: 9.99,
        quantity: 1,
      );

      cartService.removeItemById('test_001');

      expect(cartService.items.length, 1);
      expect(cartService.items.first.id, 'test_002');
    });

    test('should clear all items from cart', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product 1',
        price: 19.99,
        quantity: 1,
      );

      cartService.addItem(
        id: 'test_002',
        name: 'Test Product 2',
        price: 9.99,
        quantity: 2,
      );

      expect(cartService.items.length, 2);

      cartService.clearCart();

      expect(cartService.items, isEmpty);
      expect(cartService.itemCount, 0);
      expect(cartService.subtotal, 0.0);
    });

    test('should calculate correct item count with multiple items', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product 1',
        price: 19.99,
        quantity: 2,
      );

      cartService.addItem(
        id: 'test_002',
        name: 'Test Product 2',
        price: 9.99,
        quantity: 3,
      );

      expect(cartService.itemCount, 5);
    });

    test('should calculate correct subtotal', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product 1',
        price: 10.00,
        quantity: 2,
      );

      cartService.addItem(
        id: 'test_002',
        name: 'Test Product 2',
        price: 5.00,
        quantity: 3,
      );

      expect(cartService.subtotal, 35.00);
    });

    test('should calculate subtotal with decimal prices', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product 1',
        price: 14.99,
        quantity: 1,
      );

      cartService.addItem(
        id: 'test_002',
        name: 'Test Product 2',
        price: 9.99,
        quantity: 2,
      );

      expect(cartService.subtotal, closeTo(34.97, 0.01));
    });

    test('should get item by id, color, size, and customText', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
        color: 'Red',
        size: 'M',
        customText: 'Custom',
      );

      final item = cartService.getItem(
        id: 'test_001',
        color: 'Red',
        size: 'M',
        customText: 'Custom',
      );

      expect(item, isNotNull);
      expect(item?.name, 'Test Product');
    });

    test('should return null when getting non-existent item', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
        color: 'Red',
      );

      final item = cartService.getItem(
        id: 'test_001',
        color: 'Blue',
      );

      expect(item, isNull);
    });

    test('should return immutable list of items', () {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
      );

      final items = cartService.items;

      // This should throw an error because items is unmodifiable
      expect(
          () => items.add(CartItem(
                id: 'test_002',
                name: 'Another Product',
                price: 9.99,
                quantity: 1,
              )),
          throwsUnsupportedError);
    });

    test('should notify listeners when items are added', () async {
      bool listenerCalled = false;

      cartService.addListener(() {
        listenerCalled = true;
      });

      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
      );

      await Future.delayed(Duration.zero);
      expect(listenerCalled, isTrue);
    });

    test('should notify listeners when quantity is updated', () async {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
      );

      bool listenerCalled = false;

      cartService.addListener(() {
        listenerCalled = true;
      });

      final item = cartService.items.first;
      cartService.updateQuantity(item, 3);

      await Future.delayed(Duration.zero);
      expect(listenerCalled, isTrue);
    });

    test('should notify listeners when items are removed', () async {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
      );

      bool listenerCalled = false;

      cartService.addListener(() {
        listenerCalled = true;
      });

      final item = cartService.items.first;
      cartService.removeItem(item);

      await Future.delayed(Duration.zero);
      expect(listenerCalled, isTrue);
    });

    test('should notify listeners when cart is cleared', () async {
      cartService.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
      );

      bool listenerCalled = false;

      cartService.addListener(() {
        listenerCalled = true;
      });

      cartService.clearCart();

      await Future.delayed(Duration.zero);
      expect(listenerCalled, isTrue);
    });

    test('CartService should be a singleton', () {
      final instance1 = CartService();
      final instance2 = CartService();

      expect(instance1, same(instance2));
    });

    test('singleton should maintain state across instances', () {
      final instance1 = CartService();
      instance1.addItem(
        id: 'test_001',
        name: 'Test Product',
        price: 19.99,
        quantity: 1,
      );

      final instance2 = CartService();
      expect(instance2.items.length, 1);
      expect(instance2.items.first.name, 'Test Product');
    });
  });
}
