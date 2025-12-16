import 'package:flutter/material.dart';

class AppNavbar extends StatelessWidget {
  const AppNavbar({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void navigateToPrintShack(BuildContext context) {
    Navigator.pushNamed(context, '/print_shack');
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
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
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
                height: 80,
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth < 650 ? 16 : 24),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigateToHome(context);
                      },
                      child: Image.network(
                        'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                        height: logoHeight,
                        fit: BoxFit.cover,
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
                    SizedBox(width: screenWidth < 650 ? 8 : 16),
                    if (screenWidth >= 650)
                      Expanded(
                        child: Wrap(
                          spacing: 12,
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
                                navigateToHome(context);
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
                                navigateToHome(context);
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
                    SizedBox(width: screenWidth < 650 ? 8 : 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            size: isSmallScreen ? 28.0 : 18.0,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: BoxConstraints(
                            minWidth: isSmallScreen ? 48.0 : 32.0,
                            minHeight: isSmallScreen ? 48.0 : 32.0,
                          ),
                          onPressed: placeholderCallbackForButtons,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.person_outline,
                            size: isSmallScreen ? 28.0 : 18.0,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: BoxConstraints(
                            minWidth: isSmallScreen ? 48.0 : 32.0,
                            minHeight: isSmallScreen ? 48.0 : 32.0,
                          ),
                          onPressed: placeholderCallbackForButtons,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.shopping_bag_outlined,
                            size: isSmallScreen ? 28.0 : 18.0,
                            color: Colors.grey,
                          ),
                          padding: const EdgeInsets.all(8),
                          constraints: BoxConstraints(
                            minWidth: isSmallScreen ? 48.0 : 32.0,
                            minHeight: isSmallScreen ? 48.0 : 32.0,
                          ),
                          onPressed: placeholderCallbackForButtons,
                        ),
                        if (isSmallScreen)
                          PopupMenuButton<String>(
                            icon: Icon(
                              Icons.menu,
                              size: isSmallScreen ? 28.0 : 18.0,
                              color: Colors.grey,
                            ),
                            padding: const EdgeInsets.all(8),
                            constraints: BoxConstraints(
                              minWidth: isSmallScreen ? 48.0 : 32.0,
                              minHeight: isSmallScreen ? 48.0 : 32.0,
                            ),
                            onSelected: (value) {
                              switch (value) {
                                case 'home':
                                  navigateToHome(context);
                                  break;
                                case 'shop':
                                  navigateToHome(context);
                                  break;
                                case 'print_shack':
                                  navigateToPrintShack(context);
                                  break;
                                case 'sale':
                                  navigateToHome(context);
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
