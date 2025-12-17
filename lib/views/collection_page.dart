import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_navbar.dart';
import 'package:union_shop/widgets/app_footer.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  String _filterBy = 'All products';
  String _sortBy = 'Featured';
  int _currentPage = 1;
  bool _filterMenuOpen = false;
  bool _sortMenuOpen = false;

  final List<String> _filterOptions = [
    'All products',
    'Clothing',
    'Merchandise',
    'Popular',
    'PSUT',
  ];

  final List<String> _sortOptions = [
    'Featured',
    'Best selling',
    'Alphabetically, A–Z',
    'Alphabetically, Z–A',
    'Price, low to high',
    'Price, high to low',
    'Date, old to new',
    'Date, new to old',
  ];

  final List<Map<String, String>> _allProducts = [
    {
      'name': 'Classic Hoodies',
      'price': '£25.00',
      'category': 'Clothing',
      'priceValue': '25.00',
      'date': '2024-01-01'
    },
    {
      'name': 'Classic Sweatshirts',
      'price': '£23.00',
      'category': 'Clothing',
      'priceValue': '23.00',
      'date': '2024-01-02'
    },
    {
      'name': 'Classic T-Shirts',
      'price': '£11.00',
      'category': 'Clothing',
      'priceValue': '11.00',
      'date': '2024-01-03'
    },
    {
      'name': 'Classic Sweatshirts – Neutral',
      'price': '£10.99',
      'category': 'Clothing',
      'priceValue': '10.99',
      'date': '2024-01-04'
    },
    {
      'name': 'Graduation Hoodies',
      'price': '£35.00',
      'category': 'Clothing',
      'priceValue': '35.00',
      'date': '2024-01-05'
    },
    {
      'name': 'Graduation 3/4 Zipped Sweatshirt',
      'price': '£45.00',
      'category': 'Clothing',
      'priceValue': '45.00',
      'date': '2024-01-06'
    },
    {
      'name': 'Classic Cap',
      'price': '£12.00',
      'category': 'Merchandise',
      'priceValue': '12.00',
      'date': '2024-01-07'
    },
    {
      'name': 'Classic Beanie Hat',
      'price': '£12.00',
      'category': 'Merchandise',
      'priceValue': '12.00',
      'date': '2024-01-08'
    },
    {
      'name': 'Classic Rainbow Hoodies',
      'price': '£12.99',
      'category': 'Clothing',
      'priceValue': '12.99',
      'date': '2024-01-09'
    },
    {
      'name': 'Heavyweight Shorts',
      'price': '£12.99',
      'category': 'Clothing',
      'priceValue': '12.99',
      'date': '2024-01-10'
    },
    {
      'name': 'Signature Hoodie',
      'price': '£32.99',
      'category': 'Clothing',
      'priceValue': '32.99',
      'date': '2024-01-11'
    },
    {
      'name': 'Essential T-Shirt',
      'price': '£6.99',
      'category': 'Clothing',
      'priceValue': '6.99',
      'date': '2024-01-12'
    },
    {
      'name': 'Limited Edition Essential Zip Hoodies',
      'price': '£14.99',
      'category': 'Clothing',
      'priceValue': '14.99',
      'date': '2024-01-13'
    },
    {
      'name': 'Waterproof Poncho',
      'price': '£1.99',
      'category': 'Clothing',
      'priceValue': '1.99',
      'date': '2024-01-14'
    },
    {
      'name': 'Classic Hoodies – Burgundy',
      'price': '£12.00',
      'category': 'Clothing',
      'priceValue': '12.00',
      'date': '2024-01-15'
    },
    {
      'name': 'Signature T-Shirt',
      'price': '£14.99',
      'category': 'Clothing',
      'priceValue': '14.99',
      'date': '2024-01-16'
    },
    {
      'name': 'Limited Edition UoP Beanies',
      'price': '£7.50',
      'category': 'Merchandise',
      'priceValue': '7.50',
      'date': '2024-01-17'
    },
  ];

  List<Map<String, String>> get _filteredAndSortedProducts {
    List<Map<String, String>> filtered = List.from(_allProducts);

    // Apply filter
    if (_filterBy != 'All products') {
      filtered = filtered
          .where((product) => product['category'] == _filterBy)
          .toList();
    }

    // Apply sort
    switch (_sortBy) {
      case 'Alphabetically, A–Z':
        filtered.sort((a, b) => a['name']!.compareTo(b['name']!));
        break;
      case 'Alphabetically, Z–A':
        filtered.sort((a, b) => b['name']!.compareTo(a['name']!));
        break;
      case 'Price, low to high':
        filtered.sort((a, b) => double.parse(a['priceValue']!)
            .compareTo(double.parse(b['priceValue']!)));
        break;
      case 'Price, high to low':
        filtered.sort((a, b) => double.parse(b['priceValue']!)
            .compareTo(double.parse(a['priceValue']!)));
        break;
      case 'Date, old to new':
        filtered.sort((a, b) => a['date']!.compareTo(b['date']!));
        break;
      case 'Date, new to old':
        filtered.sort((a, b) => b['date']!.compareTo(a['date']!));
        break;
      // 'Featured' and 'Best selling' keep original order
    }

    return filtered;
  }

  int get _totalProducts => _filteredAndSortedProducts.length;

  int get _totalPages => (_totalProducts / 9).ceil();

  int get _productsPerPage {
    final remaining = _totalProducts - ((_currentPage - 1) * 9);
    return remaining > 9 ? 9 : remaining;
  }

  @override
  Widget build(BuildContext context) {
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

            // Collection content
            LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = MediaQuery.of(context).size.width;
                final padding = screenWidth < 600 ? 16.0 : 40.0;
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    children: [
                      // Title
                      Text(
                        'Clothing',
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 24 : 35,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF616161),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      // First Divider
                      Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),

                      // Filter and Sort Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: screenWidth < 600
                            ? Row(
                                children: [
                                  Expanded(
                                    child: _buildDropdown(
                                      label: 'FILTER BY',
                                      value: _filterBy,
                                      items: _filterOptions,
                                      isOpen: _filterMenuOpen,
                                      isMobile: true,
                                      onChanged: (value) {
                                        setState(() {
                                          _filterBy = value!;
                                          _filterMenuOpen = false;
                                        });
                                      },
                                      onOpenChanged: (isOpen) {
                                        setState(() {
                                          _filterMenuOpen = isOpen;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildDropdown(
                                      label: 'SORT BY',
                                      value: _sortBy,
                                      items: _sortOptions,
                                      isOpen: _sortMenuOpen,
                                      isMobile: true,
                                      onChanged: (value) {
                                        setState(() {
                                          _sortBy = value!;
                                          _sortMenuOpen = false;
                                          _currentPage = 1;
                                        });
                                      },
                                      onOpenChanged: (isOpen) {
                                        setState(() {
                                          _sortMenuOpen = isOpen;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  _buildDropdown(
                                    label: 'FILTER BY',
                                    value: _filterBy,
                                    items: _filterOptions,
                                    isOpen: _filterMenuOpen,
                                    isMobile: false,
                                    onChanged: (value) {
                                      setState(() {
                                        _filterBy = value!;
                                        _filterMenuOpen = false;
                                        _currentPage = 1;
                                      });
                                    },
                                    onOpenChanged: (isOpen) {
                                      setState(() {
                                        _filterMenuOpen = isOpen;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  _buildDropdown(
                                    label: 'SORT BY',
                                    value: _sortBy,
                                    items: _sortOptions,
                                    isOpen: _sortMenuOpen,
                                    isMobile: false,
                                    onChanged: (value) {
                                      setState(() {
                                        _sortBy = value!;
                                        _sortMenuOpen = false;
                                        _currentPage = 1;
                                      });
                                    },
                                    onOpenChanged: (isOpen) {
                                      setState(() {
                                        _sortMenuOpen = isOpen;
                                      });
                                    },
                                  ),
                                  const Spacer(),
                                  Text(
                                    '$_totalProducts products',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                      ),

                      // Second Divider
                      Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),

                      // Products count for mobile
                      if (screenWidth < 600)
                        Padding(
                          padding: const EdgeInsets.only(top: 16, left: 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$_totalProducts products',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 32),

                      // Products Grid
                      if (_totalProducts == 0)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(48.0),
                            child: Text(
                              'No products found matching your filters.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        )
                      else
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1200),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final screenWidth =
                                    MediaQuery.of(context).size.width;
                                int crossAxisCount;

                                if (screenWidth < 600) {
                                  crossAxisCount = 2;
                                } else if (screenWidth < 900) {
                                  crossAxisCount = 2;
                                } else {
                                  crossAxisCount = 3;
                                }

                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing:
                                        screenWidth < 600 ? 4 : 24,
                                    mainAxisSpacing:
                                        screenWidth < 600 ? 16 : 32,
                                    childAspectRatio:
                                        screenWidth < 600 ? 0.85 : 1.1,
                                  ),
                                  itemCount: _productsPerPage,
                                  itemBuilder: (context, index) {
                                    final productIndex =
                                        (_currentPage - 1) * 9 + index;
                                    final product = _filteredAndSortedProducts[
                                        productIndex];

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/product');
                                      },
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                flex: 7,
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                  ),
                                                  child: Image.network(
                                                    'https://upsu-store.myshopify.com/cdn/shop/files/0D5A5103_da3f11e8-86a2-4f35-a49d-8f41f99f9d02.jpg?v=1734103677',
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Center(
                                                        child: Text(
                                                          'Product ${productIndex + 1}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Flexible(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      product['name']!,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[800],
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      product['price']!,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      const SizedBox(height: 48),

                      // Page Navigation
                      if (_totalPages > 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Previous button
                            InkWell(
                              onTap: _currentPage > 1
                                  ? () {
                                      setState(() {
                                        _currentPage--;
                                      });
                                    }
                                  : null,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _currentPage > 1
                                        ? Colors.black
                                        : Colors.grey[400]!,
                                  ),
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 18,
                                  color: _currentPage > 1
                                      ? Colors.black
                                      : Colors.grey[400],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Page $_currentPage of $_totalPages',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Next button
                            InkWell(
                              onTap: _currentPage < _totalPages
                                  ? () {
                                      setState(() {
                                        _currentPage++;
                                      });
                                    }
                                  : null,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _currentPage < _totalPages
                                        ? Colors.black
                                        : Colors.grey[400]!,
                                  ),
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                  color: _currentPage < _totalPages
                                      ? Colors.black
                                      : Colors.grey[400],
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
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

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required bool isOpen,
    required bool isMobile,
    required ValueChanged<String?> onChanged,
    required ValueChanged<bool> onOpenChanged,
  }) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          PopupMenuButton<String>(
            offset: const Offset(0, 0),
            position: PopupMenuPosition.under,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(color: Colors.black, width: 1),
            ),
            color: Colors.white,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: isOpen ? Colors.black : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_drop_down, color: Colors.black),
                ],
              ),
            ),
            onOpened: () {
              onOpenChanged(true);
            },
            onCanceled: () {
              onOpenChanged(false);
            },
            itemBuilder: (BuildContext context) {
              return items.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  padding: EdgeInsets.zero,
                  child: Container(
                    width: double.infinity,
                    color: item == value ? Colors.blue : Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: item == value ? Colors.white : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList();
            },
            onSelected: onChanged,
          ),
        ],
      );
    }

    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(width: 8),
        PopupMenuButton<String>(
          offset: const Offset(0, 0),
          position: PopupMenuPosition.under,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: Colors.black, width: 1),
          ),
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: isOpen ? Colors.black : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
          ),
          onOpened: () {
            onOpenChanged(true);
          },
          onCanceled: () {
            onOpenChanged(false);
          },
          itemBuilder: (BuildContext context) {
            return items.map((String item) {
              return PopupMenuItem<String>(
                value: item,
                padding: EdgeInsets.zero,
                child: Container(
                  width: double.infinity,
                  color: item == value ? Colors.blue : Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: item == value ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }).toList();
          },
          onSelected: onChanged,
        ),
      ],
    );
  }
}
