import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_footer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  Widget _buildCategoryCard(String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
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
                      'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
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
                                    if (isSmallScreen)
                                      PopupMenuButton<String>(
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
            ),

            // Hero Section
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ),
                  // Content overlay
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Placeholder Hero Title',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "This is placeholder text for the hero section.",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: placeholderCallbackForButtons,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text(
                            'BROWSE PRODUCTS',
                            style: TextStyle(fontSize: 14, letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Products Section
            Container(
              color: Colors.white,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        const Text(
                          'ESSENTIAL RANGE - OVER 20% OFF!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Essential Range Products (2 products)
                        Center(
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 24,
                            alignment: WrapAlignment.center,
                            children: const [
                              SizedBox(
                                width: 350,
                                height: 320,
                                child: ProductCard(
                                  title: 'Placeholder Product 1',
                                  price: '£10.00',
                                  imageUrl:
                                      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                ),
                              ),
                              SizedBox(
                                width: 350,
                                height: 320,
                                child: ProductCard(
                                  title: 'Placeholder Product 2',
                                  price: '£15.00',
                                  imageUrl:
                                      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 60),

                        // Signature Range Title
                        const Text(
                          'SIGNATURE RANGE',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Signature Range Products (2 products)
                        Center(
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 24,
                            alignment: WrapAlignment.center,
                            children: const [
                              SizedBox(
                                width: 350,
                                height: 320,
                                child: ProductCard(
                                  title: 'Placeholder Product 3',
                                  price: '£20.00',
                                  imageUrl:
                                      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                ),
                              ),
                              SizedBox(
                                width: 350,
                                height: 320,
                                child: ProductCard(
                                  title: 'Placeholder Product 4',
                                  price: '£25.00',
                                  imageUrl:
                                      'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 60),

                        // Portsmouth City Collection Title
                        const Text(
                          'PORTSMOUTH CITY COLLECTION',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Portsmouth City Collection Products (4 products)
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 732),
                            child: Wrap(
                              spacing: 16,
                              runSpacing: 24,
                              alignment: WrapAlignment.start,
                              children: const [
                                SizedBox(
                                  width: 350,
                                  height: 320,
                                  child: ProductCard(
                                    title: 'Portsmouth City Product 1',
                                    price: '£12.00',
                                    imageUrl:
                                        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                ),
                                SizedBox(
                                  width: 350,
                                  height: 320,
                                  child: ProductCard(
                                    title: 'Portsmouth City Product 2',
                                    price: '£16.00',
                                    imageUrl:
                                        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                ),
                                SizedBox(
                                  width: 350,
                                  height: 320,
                                  child: ProductCard(
                                    title: 'Portsmouth City Product 3',
                                    price: '£14.00',
                                    imageUrl:
                                        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                ),
                                SizedBox(
                                  width: 350,
                                  height: 320,
                                  child: ProductCard(
                                    title: 'Portsmouth City Product 4',
                                    price: '£18.00',
                                    imageUrl:
                                        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),

                        // View All Button
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text(
                            'VIEW ALL',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),

                        // Our Range Title
                        const Text(
                          'OUR RANGE',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 48),

                        // Our Range Categories (4 columns)
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 900
                                  ? 4
                                  : MediaQuery.of(context).size.width > 600
                                      ? 2
                                      : 1,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: 1,
                          children: [
                            _buildCategoryCard('CLOTHING'),
                            _buildCategoryCard('MERCHANDISE'),
                            _buildCategoryCard('GRADUATION'),
                            _buildCategoryCard('SALE'),
                          ],
                        ),
                        const SizedBox(height: 60),

                        // Add Personal Touch Section
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isSmallScreen =
                                MediaQuery.of(context).size.width < 800;

                            if (isSmallScreen) {
                              // Mobile layout: Image on top, text below
                              return Column(
                                children: [
                                  // Image placeholder
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  // Text and button
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Add a Personal Touch',
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'First add your item of clothing to your cart then click below to add your text! One line of text contains 10 characters!',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          height: 1.5,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF4d2963),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 40,
                                            vertical: 16,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                        child: const Text(
                                          'CLICK HERE TO ADD TEXT!',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              // Desktop layout: Text on left, image on right
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Text and button side
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 40),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Add a Personal Touch',
                                            style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            'First add your item of clothing to your cart then click below to add your text! One line of text contains 10 characters!',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              height: 1.5,
                                            ),
                                          ),
                                          const SizedBox(height: 24),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF4d2963),
                                              foregroundColor: Colors.white,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 40,
                                                vertical: 16,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                            child: const Text(
                                              'CLICK HERE TO ADD TEXT!',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Image placeholder
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
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
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child:
                          Icon(Icons.image_not_supported, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
