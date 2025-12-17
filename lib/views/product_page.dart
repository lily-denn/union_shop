// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_navbar.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/services/cart_service.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final CartService _cartService = CartService();
  String _selectedColor = 'Baby Pink';
  String _selectedSize = 'M';
  int _quantity = 1;
  int _selectedImageIndex = 0;
  late TextEditingController _quantityController;

  final List<String> _colors = ['Baby Pink', 'Stone Blue', 'Black', 'Grey'];
  final List<String> _sizes = ['S', 'M', 'L'];
  final List<String> _productImages = [
    'https://shop.upsu.net/cdn/shop/files/Pink_Essential_Hoodie_2a3589c2-096f-479f-ac60-d41e8a853d04_1024x1024@2x.jpg?v=1749131089',
    'https://shop.upsu.net/cdn/shop/files/1000045774_07de1185-b921-47fa-b3a8-b1823478ca2b_1024x1024@2x.jpg?v=1749131089',
    'https://shop.upsu.net/cdn/shop/files/Baby_Pink_Shopify_Image_1024x1024@2x.png?v=1749460435',
    'https://shop.upsu.net/cdn/shop/files/Blue_Stone_Shopify_Image_1024x1024@2x.png?v=1749460441',
  ];

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(text: _quantity.toString());
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _updateQuantity(int newQuantity) {
    setState(() {
      _quantity = newQuantity;
      _quantityController.text = _quantity.toString();
    });
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const AppNavbar(),

            // Divider
            Container(
              height: 1,
              color: Colors.grey[300],
            ),

            // Product content
            LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = MediaQuery.of(context).size.width;
                final padding = screenWidth < 600 ? 16.0 : 40.0;
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(padding),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left side - Images
                                Expanded(
                                  flex: 1,
                                  child: _buildImageSection(),
                                ),
                                const SizedBox(width: 60),
                                // Right side - Product details
                                Expanded(
                                  flex: 1,
                                  child: _buildProductDetails(),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _buildImageSection(),
                                const SizedBox(height: 32),
                                _buildProductDetails(),
                              ],
                            ),
                    ),
                  ),
                );
              },
            ),

            // Footer
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth < 600 ? 300.0 : 500.0;
    final thumbnailSize = screenWidth < 600 ? 60.0 : 80.0;

    return Column(
      children: [
        // Main image
        Container(
          height: imageHeight,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              _productImages[_selectedImageIndex],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported,
                        size: 80, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Thumbnail images
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(4, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedImageIndex = index;
                  });
                },
                child: Container(
                  width: thumbnailSize,
                  height: thumbnailSize,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selectedImageIndex == index
                          ? const Color(0xFF4d2963)
                          : Colors.grey[300]!,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      _productImages[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.image,
                              size: 30, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        const Text(
          'Limited Edition Essential Zip Hoodies',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),

        // Price
        Row(
          children: [
            Text(
              '£20.00',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              '£14.99',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4d2963),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Tax included.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 32),

        // Color, Size and Quantity - responsive layout
        LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;

            if (availableWidth > 500) {
              // Wide: All in one row (Color, Size, Quantity)
              return Row(
                children: [
                  // Color
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Color',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedColor,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                          ),
                          items: _colors.map((color) {
                            return DropdownMenuItem(
                              value: color,
                              child: Text(color),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedColor = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Size
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Size',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedSize,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                          ),
                          items: _sizes.map((size) {
                            return DropdownMenuItem(
                              value: size,
                              child: Text(size),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedSize = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Quantity (smaller)
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            suffixIcon: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _updateQuantity(_quantity + 1);
                                  },
                                  child:
                                      const Icon(Icons.arrow_drop_up, size: 20),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_quantity > 1) {
                                      _updateQuantity(_quantity - 1);
                                    }
                                  },
                                  child: const Icon(Icons.arrow_drop_down,
                                      size: 20),
                                ),
                              ],
                            ),
                          ),
                          onChanged: (value) {
                            final newQuantity = int.tryParse(value);
                            if (newQuantity != null && newQuantity > 0) {
                              _updateQuantity(newQuantity);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (availableWidth > 250) {
              // Medium: Color and Size in row, Quantity below
              return Column(
                children: [
                  // Color and Size row
                  Row(
                    children: [
                      // Color
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Color',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: _selectedColor,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                              ),
                              items: _colors.map((color) {
                                return DropdownMenuItem(
                                  value: color,
                                  child: Text(color),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedColor = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Size
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Size',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: _selectedSize,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                              ),
                              items: _sizes.map((size) {
                                return DropdownMenuItem(
                                  value: size,
                                  child: Text(size),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedSize = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Quantity
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          suffixIcon: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  _updateQuantity(_quantity + 1);
                                },
                                child:
                                    const Icon(Icons.arrow_drop_up, size: 20),
                              ),
                              InkWell(
                                onTap: () {
                                  if (_quantity > 1) {
                                    _updateQuantity(_quantity - 1);
                                  }
                                },
                                child:
                                    const Icon(Icons.arrow_drop_down, size: 20),
                              ),
                            ],
                          ),
                        ),
                        onChanged: (value) {
                          final newQuantity = int.tryParse(value);
                          if (newQuantity != null && newQuantity > 0) {
                            _updateQuantity(newQuantity);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              );
            } else {
              // Smallest: Color on top, Size and Quantity in row below
              return Column(
                children: [
                  // Color
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Color',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedColor,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                        ),
                        items: _colors.map((color) {
                          return DropdownMenuItem(
                            value: color,
                            child: Text(color),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedColor = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Size and Quantity row
                  Row(
                    children: [
                      // Size
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Size',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: _selectedSize,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                              ),
                              items: _sizes.map((size) {
                                return DropdownMenuItem(
                                  value: size,
                                  child: Text(size),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedSize = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Quantity
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Quantity',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]!),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                suffixIcon: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _updateQuantity(_quantity + 1);
                                      },
                                      child: const Icon(Icons.arrow_drop_up,
                                          size: 20),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (_quantity > 1) {
                                          _updateQuantity(_quantity - 1);
                                        }
                                      },
                                      child: const Icon(Icons.arrow_drop_down,
                                          size: 20),
                                    ),
                                  ],
                                ),
                              ),
                              onChanged: (value) {
                                final newQuantity = int.tryParse(value);
                                if (newQuantity != null && newQuantity > 0) {
                                  _updateQuantity(newQuantity);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 24),

        // Add to cart button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              _cartService.addItem(
                id: 'hoodie_001',
                name: 'Limited Edition Essential Zip Hoodie',
                price: 14.99,
                quantity: _quantity,
                color: _selectedColor,
                size: _selectedSize,
                imageUrl: _productImages[0],
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added $_quantity item(s) to cart'),
                  duration: const Duration(seconds: 2),
                  backgroundColor: const Color(0xFF4d2963),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Color(0xFF4d2963), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'Add to cart',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4d2963),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Buy with Shop button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text(
              'Buy with Shop',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // More payment options
        Center(
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'More payment options',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF4d2963),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Product description
        const Text(
          'Redesigned with a fresh chest logo, our limited addition Baby Pink and Stone Blue Hoodies are ultra cosy made for everyday wear with a modern twist. Soft, durable, and effortlessly versatile.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
