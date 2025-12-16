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
  final int _totalPages = 2;
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

  int get _productsPerPage => _currentPage == 1 ? 9 : 8;

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
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: screenWidth < 600
                              ? Row(
                                  children: [
                                    _buildDropdown(
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
                                    const SizedBox(width: 16),
                                    _buildDropdown(
                                      label: 'SORT BY',
                                      value: _sortBy,
                                      items: _sortOptions,
                                      isOpen: _sortMenuOpen,
                                      isMobile: true,
                                      onChanged: (value) {
                                        setState(() {
                                          _sortBy = value!;
                                          _sortMenuOpen = false;
                                        });
                                      },
                                      onOpenChanged: (isOpen) {
                                        setState(() {
                                          _sortMenuOpen = isOpen;
                                        });
                                      },
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
                                      '17 products',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
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
                              '17 products',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 32),

                      // Products Grid
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
                                  crossAxisSpacing: screenWidth < 600 ? 12 : 24,
                                  mainAxisSpacing: 32,
                                  childAspectRatio:
                                      screenWidth < 600 ? 0.9 : 1.1,
                                ),
                                itemCount: _productsPerPage,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1.4,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Product ${(_currentPage - 1) * 9 + index + 1}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Placeholder Product Title',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '£20.00',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Page Navigation
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
