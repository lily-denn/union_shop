import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_navbar.dart';
import 'package:union_shop/widgets/app_footer.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<CartItem> _cartItems = [
    CartItem(
      id: '1',
      name: 'Limited Edition Essential Zip Hoodie',
      price: 14.99,
      quantity: 1,
      color: 'Baby Pink',
      size: 'M',
    ),
    CartItem(
      id: '2',
      name: 'Classic T-Shirt',
      price: 9.99,
      quantity: 2,
      color: 'Black',
      size: 'L',
    ),
  ];

  final Map<String, bool> _editingStates = {};
  final Map<String, TextEditingController> _quantityControllers = {};

  @override
  void initState() {
    super.initState();
    for (var item in _cartItems) {
      _editingStates[item.id] = false;
      _quantityControllers[item.id] =
          TextEditingController(text: item.quantity.toString());
    }
  }

  @override
  void dispose() {
    for (var controller in _quantityControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  double get subtotal {
    return _cartItems.fold(
        0, (sum, item) => sum + (item.price * item.quantity));
  }

  void _removeItem(String id) {
    setState(() {
      _cartItems.removeWhere((item) => item.id == id);
      _editingStates.remove(id);
      _quantityControllers[id]?.dispose();
      _quantityControllers.remove(id);
    });
  }

  void _updateQuantity(String id, int newQuantity) {
    if (newQuantity > 0) {
      setState(() {
        final item = _cartItems.firstWhere((item) => item.id == id);
        item.quantity = newQuantity;
        _quantityControllers[id]?.text = newQuantity.toString();
      });
    }
  }

  void _handleQuantityChange(String id, String value) {
    final newQuantity = int.tryParse(value);
    if (newQuantity != null && newQuantity > 0) {
      _updateQuantity(id, newQuantity);
    } else {
      // Revert to current quantity if invalid input
      final item = _cartItems.firstWhere((item) => item.id == id);
      _quantityControllers[id]?.text = item.quantity.toString();
    }
  }

  void _toggleEditing(String id) {
    setState(() {
      _editingStates[id] = !_editingStates[id]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppNavbar(),
            Container(
              height: 1,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child:
                      isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
                ),
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and Continue Shopping - Centered
        Center(
          child: Column(
            children: [
              const Text(
                'Your cart',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/collections');
                },
                child: const Text(
                  'Continue shopping',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4d2963),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Column Headers
        Row(
          children: [
            const Expanded(
              flex: 3,
              child: Text(
                'PRODUCT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'PRICE',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'QUANTITY',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'TOTAL',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Divider(height: 1, color: Colors.grey[300]),

        // Cart Items
        ..._cartItems.map((item) => _buildDesktopCartItem(item)),

        const SizedBox(height: 32),

        // Bottom Section
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Note Section
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add a note to your order',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 60),

            // Subtotal Section
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Subtotal',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Text(
                        '£${subtotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tax included and shipping calculated at checkout',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Update Button
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          side: const BorderSide(
                            color: Color(0xFF4d2963),
                            width: 2,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          'UPDATE',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4d2963),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Checkout Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4d2963),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          'CHECKOUT',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopCartItem(CartItem item) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            // Product Info
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  // Product Image
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(Icons.image, size: 40, color: Colors.grey[400]),
                  ),
                  const SizedBox(width: 16),
                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Color: ${item.color}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'Size: ${item.size}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Remove Button (visible on desktop only)
                        InkWell(
                          onTap: () => _removeItem(item.id),
                          child: const Text(
                            'Remove',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4d2963),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Price
            Expanded(
              flex: 1,
              child: Text(
                '£${item.price.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),

            // Quantity
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    child: TextFormField(
                      controller: _quantityControllers[item.id],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        suffixIcon: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                _updateQuantity(item.id, item.quantity + 1);
                              },
                              child: const Icon(Icons.arrow_drop_up, size: 20),
                            ),
                            InkWell(
                              onTap: () {
                                if (item.quantity > 1) {
                                  _updateQuantity(item.id, item.quantity - 1);
                                }
                              },
                              child:
                                  const Icon(Icons.arrow_drop_down, size: 20),
                            ),
                          ],
                        ),
                      ),
                      onChanged: (value) {
                        _handleQuantityChange(item.id, value);
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Total
            Expanded(
              flex: 1,
              child: Text(
                '£${(item.price * item.quantity).toStringAsFixed(2)}',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Divider(height: 1, color: Colors.grey[300]),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and Continue Shopping - Centered
        Center(
          child: Column(
            children: [
              const Text(
                'Your cart',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/collections');
                },
                child: const Text(
                  'Continue shopping',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4d2963),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Column Headers (Product and Price only)
        Row(
          children: [
            const Expanded(
              flex: 2,
              child: Text(
                'PRODUCT',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'PRICE',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Divider(height: 1, color: Colors.grey[300]),

        // Cart Items
        ..._cartItems.map((item) => _buildMobileCartItem(item)),

        const SizedBox(height: 24),
        Divider(height: 1, color: Colors.grey[300]),
        const SizedBox(height: 24),

        // Note Section
        const Text(
          'Add a note to your order',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(height: 24),

        // Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Subtotal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              '£${subtotal.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Tax included and shipping calculated at checkout',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 24),

        // Checkout Button (full width on mobile)
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              'CHECKOUT',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileCartItem(CartItem item) {
    final isEditing = _editingStates[item.id] ?? false;

    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Info
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(Icons.image, size: 30, color: Colors.grey[400]),
                  ),
                  const SizedBox(width: 12),
                  // Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Color: ${item.color}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'Size: ${item.size}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Edit/Cancel Button
                        GestureDetector(
                          onTap: () => _toggleEditing(item.id),
                          child: Text(
                            isEditing ? 'Cancel' : 'Edit',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF7B2D8B),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Price
            Expanded(
              flex: 1,
              child: Text(
                '£${item.price.toStringAsFixed(2)}',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),

        // Editing Section
        if (isEditing) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Remove Button
                GestureDetector(
                  onTap: () => _removeItem(item.id),
                  child: const Text(
                    'Remove',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7B2D8B),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Quantity Controls
                Row(
                  children: [
                    const Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: _quantityControllers[item.id],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF7B2D8B)),
                          ),
                          suffixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () =>
                                    _updateQuantity(item.id, item.quantity + 1),
                                child:
                                    const Icon(Icons.arrow_drop_up, size: 20),
                              ),
                              InkWell(
                                onTap: () {
                                  if (item.quantity > 1) {
                                    _updateQuantity(item.id, item.quantity - 1);
                                  }
                                },
                                child:
                                    const Icon(Icons.arrow_drop_down, size: 20),
                              ),
                            ],
                          ),
                        ),
                        onChanged: (value) =>
                            _handleQuantityChange(item.id, value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Update Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _toggleEditing(item.id),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: Color(0xFF7B2D8B)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7B2D8B),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 16),
        Divider(height: 1, color: Colors.grey[300]),
      ],
    );
  }
}

class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;
  final String color;
  final String size;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.color,
    required this.size,
  });
}
