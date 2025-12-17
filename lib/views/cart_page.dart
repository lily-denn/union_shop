import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_navbar.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/models/cart_model.dart' as model;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService _cartService = CartService();
  final Map<String, bool> _editingStates = {};
  final Map<String, TextEditingController> _quantityControllers = {};
  bool _showCheckoutConfirmation = false;

  @override
  void initState() {
    super.initState();
    _cartService.addListener(_onCartChanged);
    _initializeControllers();
  }

  @override
  void dispose() {
    _cartService.removeListener(_onCartChanged);
    for (var controller in _quantityControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {
      _initializeControllers();
    });
  }

  void _initializeControllers() {
    for (var item in _cartService.items) {
      final key = '${item.id}_${item.color}_${item.size}_${item.customText}';
      if (!_editingStates.containsKey(key)) {
        _editingStates[key] = false;
      }
      if (!_quantityControllers.containsKey(key)) {
        _quantityControllers[key] =
            TextEditingController(text: item.quantity.toString());
      } else {
        _quantityControllers[key]?.text = item.quantity.toString();
      }
    }
  }

  double get subtotal => _cartService.subtotal;

  void _removeItem(model.CartItem item) {
    _cartService.removeItem(item);
    final key = '${item.id}_${item.color}_${item.size}_${item.customText}';
    _editingStates.remove(key);
    _quantityControllers[key]?.dispose();
    _quantityControllers.remove(key);
  }

  void _updateQuantity(model.CartItem item, int newQuantity) {
    if (newQuantity > 0) {
      _cartService.updateQuantity(item, newQuantity);
    }
  }

  void _handleQuantityChange(model.CartItem item, String value) {
    final newQuantity = int.tryParse(value);
    if (newQuantity != null && newQuantity > 0) {
      _updateQuantity(item, newQuantity);
    } else {
      // Revert to current quantity if invalid input
      final key = '${item.id}_${item.color}_${item.size}_${item.customText}';
      _quantityControllers[key]?.text = item.quantity.toString();
    }
  }

  void _toggleEditing(model.CartItem item) {
    final key = '${item.id}_${item.color}_${item.size}_${item.customText}';
    setState(() {
      _editingStates[key] = !(_editingStates[key] ?? false);
    });
  }

  void _handleCheckout() {
    if (_cartService.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _showCheckoutConfirmation = true;
    });
    _cartService.clearCart();

    // Hide confirmation after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showCheckoutConfirmation = false;
        });
      }
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
            if (_showCheckoutConfirmation)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                color: const Color(0xFF4d2963),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 60,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Thank you for your purchase!',
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width < 600 ? 24 : 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Your order has been confirmed',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
        ..._cartService.items.map((item) => _buildDesktopCartItem(item)),

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
                        onPressed: _handleCheckout,
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

  Widget _buildDesktopCartItem(model.CartItem item) {
    final key = '${item.id}_${item.color}_${item.size}_${item.customText}';
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
                          onTap: () => _removeItem(item),
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
                      controller: _quantityControllers[key],
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
                                _updateQuantity(item, item.quantity + 1);
                              },
                              child: const Icon(Icons.arrow_drop_up, size: 20),
                            ),
                            InkWell(
                              onTap: () {
                                if (item.quantity > 1) {
                                  _updateQuantity(item, item.quantity - 1);
                                }
                              },
                              child:
                                  const Icon(Icons.arrow_drop_down, size: 20),
                            ),
                          ],
                        ),
                      ),
                      onChanged: (value) {
                        _handleQuantityChange(item, value);
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
        ..._cartService.items.map((item) => _buildMobileCartItem(item)),

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
            onPressed: _handleCheckout,
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

  Widget _buildMobileCartItem(model.CartItem item) {
    final key = '${item.id}_${item.color}_${item.size}_${item.customText}';
    final isEditing = _editingStates[key] ?? false;

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
                          onTap: () => _toggleEditing(item),
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
                  onTap: () => _removeItem(item),
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
                        controller: _quantityControllers[key],
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
                                    _updateQuantity(item, item.quantity + 1),
                                child:
                                    const Icon(Icons.arrow_drop_up, size: 20),
                              ),
                              InkWell(
                                onTap: () {
                                  if (item.quantity > 1) {
                                    _updateQuantity(item, item.quantity - 1);
                                  }
                                },
                                child:
                                    const Icon(Icons.arrow_drop_down, size: 20),
                              ),
                            ],
                          ),
                        ),
                        onChanged: (value) =>
                            _handleQuantityChange(item, value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Update Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _toggleEditing(item),
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
