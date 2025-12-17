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
  String _selectedOption = 'One Line of Text';
  int _quantity = 1;
  int _selectedImageIndex = 0;
  final TextEditingController _line1Controller = TextEditingController();
  final TextEditingController _line2Controller = TextEditingController();
  final TextEditingController _line3Controller = TextEditingController();
  final TextEditingController _line4Controller = TextEditingController();

  final List<String> _personalisationOptions = [
    'One Line of Text',
    'Two Lines of Text',
    'Three Lines of Text',
    'Four Lines of Text',
    'Small logo(chest)',
    'Large logo(back)',
  ];

  final List<String> _productImages = [
    'https://i.imgur.com/7yZ5Z9M.jpeg',
    'https://i.imgur.com/8Z5Z9M.jpeg',
  ];

  int get _numberOfLines {
    if (_selectedOption == 'Two Lines of Text') return 2;
    if (_selectedOption == 'Three Lines of Text') return 3;
    if (_selectedOption == 'Four Lines of Text') return 4;
    return 1;
  }

  double get _basePrice {
    switch (_selectedOption) {
      case 'One Line of Text':
        return 3.00;
      case 'Two Lines of Text':
        return 5.00;
      case 'Three Lines of Text':
        return 7.50;
      case 'Four Lines of Text':
        return 10.00;
      case 'Small logo(chest)':
        return 3.50;
      case 'Large logo(back)':
        return 6.00;
      default:
        return 3.00;
    }
  }

  double get _totalPrice {
    return _basePrice * _quantity;
  }

  @override
  void dispose() {
    _line1Controller.dispose();
    _line2Controller.dispose();
    _line3Controller.dispose();
    _line4Controller.dispose();
    super.dispose();
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

            // Back to Personalisation Button - Full Width Centered
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Center(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF4d2963)),
                  label: const Text(
                    'BACK TO PERSONALISATION',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4d2963),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    side: const BorderSide(color: Color(0xFF4d2963), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
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
    final thumbnailSize = screenWidth < 600 ? 80.0 : 100.0;

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
        // Thumbnail images (only 2)
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(2, (index) {
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
          'Personalisation',
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
              '£${_totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
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

        // Per Line Dropdown
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Per Line: $_selectedOption',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedOption,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              items: _personalisationOptions.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Personalisation Lines (conditional based on selection)
        if (_selectedOption.contains('Line'))
          ...List.generate(_numberOfLines, (index) {
            final lineNumber = index + 1;
            final controller = index == 0
                ? _line1Controller
                : index == 1
                    ? _line2Controller
                    : index == 2
                        ? _line3Controller
                        : _line4Controller;

            return Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personalisation Line $lineNumber:',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller,
                      maxLength: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        counterText: '',
                        hintText: 'Enter text (max 12 characters)',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            );
          }),

        // Quantity
        SizedBox(
          width: 150,
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
                initialValue: _quantity.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  suffixIcon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        child: const Icon(Icons.arrow_drop_up, size: 20),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (_quantity > 1) _quantity--;
                          });
                        },
                        child: const Icon(Icons.arrow_drop_down, size: 20),
                      ),
                    ],
                  ),
                ),
                onChanged: (value) {
                  final newQuantity = int.tryParse(value);
                  if (newQuantity != null && newQuantity > 0) {
                    setState(() {
                      _quantity = newQuantity;
                    });
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Add to cart button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              // Build custom text from controllers
              String customText = _line1Controller.text;
              if (_numberOfLines >= 2 && _line2Controller.text.isNotEmpty) {
                customText += '\n${_line2Controller.text}';
              }
              if (_numberOfLines >= 3 && _line3Controller.text.isNotEmpty) {
                customText += '\n${_line3Controller.text}';
              }
              if (_numberOfLines >= 4 && _line4Controller.text.isNotEmpty) {
                customText += '\n${_line4Controller.text}';
              }

              _cartService.addItem(
                id: 'print_custom',
                name: 'Custom Print - $_selectedOption',
                price: _basePrice,
                quantity: _quantity,
                customText: customText,
                imageUrl: _productImages[0],
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added $_quantity custom print(s) to cart'),
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
        const SizedBox(height: 32),

        // Pricing and Information Text
        const Text(
          '£3 for one line of text! £5 for two!\n\nOne line of text is 10 characters.\n\nPlease ensure all spellings are correct before submitting your purchase as we will print your item with the exact wording you provide. We will not be responsible for any incorrect spellings printed onto your garment. Personalised items do not qualify for refunds.',
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
