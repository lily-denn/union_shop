import 'package:flutter/foundation.dart';
import 'package:union_shop/models/cart_model.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void addItem({
    required String id,
    required String name,
    required double price,
    required int quantity,
    String? color,
    String? size,
    String? customText,
    String? imageUrl,
  }) {
    final item = CartItem(
      id: id,
      name: name,
      price: price,
      quantity: quantity,
      color: color,
      size: size,
      customText: customText,
      imageUrl: imageUrl,
    );

    // Check if item already exists (same id, color, size, customText)
    final existingIndex = _items.indexWhere((existing) =>
        existing.id == item.id &&
        existing.color == item.color &&
        existing.size == item.size &&
        existing.customText == item.customText);

    if (existingIndex >= 0) {
      // Item exists, increment quantity
      _items[existingIndex].quantity += item.quantity;
    } else {
      // New item, add to cart
      _items.add(item);
    }
    notifyListeners();
  }

  void updateQuantity(CartItem item, int quantity) {
    final index = _items.indexOf(item);
    if (index >= 0 && quantity > 0) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeItemById(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  CartItem? getItem(int index,
      {required String customText,
      required String size,
      required String color,
      required String id}) {
    if (index >= 0 && index < _items.length) {
      return _items[index];
    }
    return null;
  }
}
