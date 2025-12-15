import 'package:flutter/material.dart';

class AppNavbar extends StatelessWidget {
  const AppNavbar({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Column(
        children: [
          // Top banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4d2963),
            child: const Text(
              'PLACEHOLDER HEADER TEXT',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          // Main header
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      navigateToHome(context);
                    },
                    child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                      height: 18,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          width: 18,
                          height: 18,
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    fit: FlexFit.tight,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Check screen width - hide buttons on smaller screens
                        if (MediaQuery.of(context).size.width < 800) {
                          return const SizedBox.shrink();
                        }
                        return Wrap(
                          spacing: 12,
                          runSpacing: 4,
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
                                navigateToHome(context);
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
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isSmallScreen =
                            MediaQuery.of(context).size.width < 800;
                        final iconSize = isSmallScreen ? 28.0 : 18.0;
                        final buttonSize = isSmallScreen ? 48.0 : 32.0;

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                size: iconSize,
                                color: Colors.grey,
                              ),
                              padding: const EdgeInsets.all(8),
                              constraints: BoxConstraints(
                                minWidth: buttonSize,
                                minHeight: buttonSize,
                              ),
                              onPressed: placeholderCallbackForButtons,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.person_outline,
                                size: iconSize,
                                color: Colors.grey,
                              ),
                              padding: const EdgeInsets.all(8),
                              constraints: BoxConstraints(
                                minWidth: buttonSize,
                                minHeight: buttonSize,
                              ),
                              onPressed: placeholderCallbackForButtons,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.shopping_bag_outlined,
                                size: iconSize,
                                color: Colors.grey,
                              ),
                              padding: const EdgeInsets.all(8),
                              constraints: BoxConstraints(
                                minWidth: buttonSize,
                                minHeight: buttonSize,
                              ),
                              onPressed: placeholderCallbackForButtons,
                            ),
                            isSmallScreen
                                ? PopupMenuButton<String>(
                                    icon: Icon(
                                      Icons.menu,
                                      size: iconSize,
                                      color: Colors.grey,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    constraints: BoxConstraints(
                                      minWidth: buttonSize,
                                      minHeight: buttonSize,
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
                                          navigateToHome(context);
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
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.menu,
                                      size: iconSize,
                                      color: Colors.grey,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    constraints: BoxConstraints(
                                      minWidth: buttonSize,
                                      minHeight: buttonSize,
                                    ),
                                    onPressed: placeholderCallbackForButtons,
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
