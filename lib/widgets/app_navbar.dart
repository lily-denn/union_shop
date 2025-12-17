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
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void navigateToPrintShack(BuildContext context) {
    Navigator.pushNamed(context, '/print_shack');
  }

  void navigateToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void navigateToSignIn(BuildContext context) {
    Navigator.pushNamed(context, '/sign_in');
  }

  void navigateToCart(BuildContext context) {
    Navigator.pushNamed(context, '/cart');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
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
                            TextButton(
                              onPressed: () {
                                navigateToHome(context);
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                foregroundColor: Colors.black,
                              ),
                              child: const Text('Home',
                                  style: TextStyle(fontSize: 14)),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateToCollections(context);
                              },
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 0),
                                  foregroundColor: Colors.black),
                              child: const Text('Shop',
                                  style: TextStyle(fontSize: 14)),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateToPrintShack(context);
                              },
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 0),
                                  foregroundColor: Colors.black),
                              child: const Text('The Print Shack',
                                  style: TextStyle(fontSize: 14)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CollectionPage(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 0),
                                  foregroundColor: Colors.black),
                              child: const Text('SALE!',
                                  style: TextStyle(fontSize: 14)),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateToAbout(context);
                              },
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 0),
                                  foregroundColor: Colors.black),
                              child: const Text('About',
                                  style: TextStyle(fontSize: 14)),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateToHome(context);
                              },
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 0),
                                  foregroundColor: Colors.black),
                              child: const Text('UPSU.net',
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
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
                            PopupMenuButton<String>(
                              icon: Icon(
                                Icons.menu,
                                size: 22.0,
                                color: Colors.grey,
                              ),
                              padding: const EdgeInsets.all(2),
                              constraints: const BoxConstraints(
                                minWidth: 36.0,
                                minHeight: 36.0,
                              ),
                              onSelected: (value) {
                                switch (value) {
                                  case 'home':
                                    navigateToHome(context);
                                    break;
                                  case 'shop':
                                    navigateToCollections(context);
                                    break;
                                  case 'print_shack':
                                    navigateToPrintShack(context);
                                    break;
                                  case 'sale':
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CollectionPage(),
                                      ),
                                    );
                                    break;
                                  case 'about':
                                    navigateToAbout(context);
                                    break;
                                  case 'upsu':
                                    navigateToHome(context);
                                    break;
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'home',
                                  child: Text('Home'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'shop',
                                  child: Text('Shop'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'print_shack',
                                  child: Text('The Print Shack'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'sale',
                                  child: Text('SALE!'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'about',
                                  child: Text('About'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'upsu',
                                  child: Text('UPSU.net'),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
