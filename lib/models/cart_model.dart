class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;
  final String? color;
  final String? size;
  final String? customText;
  final String? imageUrl;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.color,
    this.size,
    this.customText,
    this.imageUrl,
  });

  CartItem copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
    String? color,
    String? size,
    String? customText,
    String? imageUrl,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      size: size ?? this.size,
      customText: customText ?? this.customText,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
