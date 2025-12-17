import 'package:flutter/material.dart';
import 'package:union_shop/views/salecollection_page.dart';
import 'package:union_shop/services/cart_service.dart';

class AppNavbar extends StatefulWidget {
  const AppNavbar({super.key});

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  final CartService _cartService = CartService();
  bool _mobileMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _cartService.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    _cartService.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {});
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    setState(() {
      _mobileMenuOpen = false;
    });
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
    setState(() {
      _mobileMenuOpen = false;
    });
  }

  void navigateToPrintShackAbout(BuildContext context) {
    Navigator.pushNamed(context, '/print_shack_about');
    setState(() {
      _mobileMenuOpen = false;
    });
  }

  void navigateToPrintShack(BuildContext context) {
    Navigator.pushNamed(context, '/print_shack');
    setState(() {
      _mobileMenuOpen = false;
    });
  }

  void navigateToPersonalisation(BuildContext context) {
    Navigator.pushNamed(context, '/personalisation');
    setState(() {
      _mobileMenuOpen = false;
    });
  }

  void navigateToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
    setState(() {
      _mobileMenuOpen = false;
    });
  }

  void navigateToSignIn(BuildContext context) {
    Navigator.pushNamed(context, '/sign_in');
    setState(() {
      _mobileMenuOpen = false;
    });
  }

  void navigateToCart(BuildContext context) {
    Navigator.pushNamed(context, '/cart');
    setState(() {
      _mobileMenuOpen = false;
    });
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  Widget _buildHoverButton({
    required String text,
    required VoidCallback onPressed,
    bool hasDropdown = false,
  }) {
    return MouseRegion(
      child: StatefulBuilder(
        builder: (context, setState) {
          bool isHovered = false;
          return MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                foregroundColor: Colors.black,
                overlayColor: Colors.transparent,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      decoration: isHovered
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                  if (hasDropdown) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_drop_down,
                        size: 18, color: Colors.black),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            color: const Color(0xFF4d2963),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = MediaQuery.of(context).size.width;
                return Text(
                  'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth < 600 ? 12 : 16,
                  ),
                );
              },
            ),
          ),
          // Main header
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = MediaQuery.of(context).size.width;
              final isSmallScreen = screenWidth < 650;
              final logoHeight = isSmallScreen
                  ? 40.0
                  : (35.0 - ((1200 - screenWidth.clamp(650, 1200)) / 550 * 13))
                      .clamp(22.0, 35.0);

              return Container(
                height: isSmallScreen ? 60 : 80,
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth < 650 ? 8 : 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 0,
                      child: GestureDetector(
                        onTap: () {
                          navigateToHome(context);
                        },
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: screenWidth * 0.25,
                          ),
                          child: Image.network(
                            'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                            height: logoHeight,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                width: logoHeight,
                                height: logoHeight,
                                child: const Center(
                                  child: Icon(Icons.image_not_supported,
                                      color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    if (screenWidth >= 900) ...[
                      const SizedBox(width: 16),
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            _buildHoverButton(
                              text: 'Home',
                              onPressed: () => navigateToHome(context),
                            ),
                            _buildHoverButton(
                              text: 'Shop',
                              onPressed: () => navigateToCollections(context),
                            ),
                            _buildHoverButton(
                              text: 'The Print Shack',
                              onPressed: () =>
                                  navigateToPrintShackAbout(context),
                            ),
                            _buildHoverButton(
                              text: 'About',
                              onPressed: () => navigateToAbout(context),
                            ),
                            _buildHoverButton(
                              text: 'SALE!',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CollectionPage(),
                                  ),
                                );
                              },
                            ),
                            _buildHoverButton(
                              text: 'UPSU.net',
                              onPressed: () => navigateToHome(context),
                            ),
                          ],
                        ),
                      ),
                    ] else
                      const Spacer(),
                    Flexible(
                      flex: 0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              size: screenWidth < 900 ? 22.0 : 18.0,
                              color: Colors.grey,
                            ),
                            padding: EdgeInsets.all(screenWidth < 900 ? 2 : 8),
                            constraints: BoxConstraints(
                              minWidth: screenWidth < 900 ? 36.0 : 32.0,
                              minHeight: screenWidth < 900 ? 36.0 : 32.0,
                            ),
                            onPressed: placeholderCallbackForButtons,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.person_outline,
                              size: screenWidth < 900 ? 22.0 : 18.0,
                              color: Colors.grey,
                            ),
                            padding: EdgeInsets.all(screenWidth < 900 ? 2 : 8),
                            constraints: BoxConstraints(
                              minWidth: screenWidth < 900 ? 36.0 : 32.0,
                              minHeight: screenWidth < 900 ? 36.0 : 32.0,
                            ),
                            onPressed: () {
                              navigateToSignIn(context);
                            },
                          ),
                          Badge(
                            isLabelVisible: _cartService.itemCount > 0,
                            label: Text(
                              _cartService.itemCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.purple,
                            child: IconButton(
                              icon: Icon(
                                Icons.shopping_bag_outlined,
                                size: screenWidth < 900 ? 22.0 : 18.0,
                                color: Colors.grey,
                              ),
                              padding:
                                  EdgeInsets.all(screenWidth < 900 ? 2 : 8),
                              constraints: BoxConstraints(
                                minWidth: screenWidth < 900 ? 36.0 : 32.0,
                                minHeight: screenWidth < 900 ? 36.0 : 32.0,
                              ),
                              onPressed: () {
                                navigateToCart(context);
                              },
                            ),
                          ),
                          if (screenWidth < 900)
                            IconButton(
                              icon: Icon(
                                _mobileMenuOpen ? Icons.close : Icons.menu,
                                size: 22.0,
                                color: Colors.grey,
                              ),
                              padding: const EdgeInsets.all(2),
                              constraints: const BoxConstraints(
                                minWidth: 36.0,
                                minHeight: 36.0,
                              ),
                              onPressed: () {
                                setState(() {
                                  _mobileMenuOpen = !_mobileMenuOpen;
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Mobile menu dropdown
          if (_mobileMenuOpen)
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  _buildMobileMenuItem('Home', () => navigateToHome(context)),
                  const Divider(height: 1, thickness: 1),
                  _buildMobileMenuItem(
                      'Shop', () => navigateToCollections(context)),
                  const Divider(height: 1, thickness: 1),
                  _buildMobileMenuItem('The Print Shack',
                      () => navigateToPrintShackAbout(context)),
                  const Divider(height: 1, thickness: 1),
                  _buildMobileMenuItem('About', () => navigateToAbout(context)),
                  const Divider(height: 1, thickness: 1),
                  _buildMobileMenuItem('SALE!', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CollectionPage(),
                      ),
                    );
                  }),
                  const Divider(height: 1, thickness: 1),
                  _buildMobileMenuItem(
                      'UPSU.net', () => navigateToHome(context)),
                  const Divider(height: 1, thickness: 1),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMobileMenuItem(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
