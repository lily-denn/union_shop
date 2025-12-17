import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/widgets/app_navbar.dart';
import 'package:union_shop/views/collection_page.dart';
import 'package:union_shop/views/personalisation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  Widget _buildCategoryCard(BuildContext context, String label) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CollectionPage(),
          ),
        );
      },
      child: Container(
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
            const AppNavbar(),

            // Hero Section
            LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = MediaQuery.of(context).size.width;
                final heroHeight = screenWidth < 600 ? 300.0 : 400.0;
                return SizedBox(
                  height: heroHeight,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Background image
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                          ),
                          child: Image.network(
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              // Silently return empty container on error (e.g., in tests)
                              return Container(
                                color: Colors.grey[300],
                              );
                            },
                            frameBuilder: (context, child, frame,
                                wasSynchronouslyLoaded) {
                              if (frame == null) {
                                return Container(color: Colors.grey[300]);
                              }
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  child,
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.black.withValues(alpha: 0.7),
                                    ),
                                  ),
                                ],
                              );
                            },
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
                                style:
                                    TextStyle(fontSize: 14, letterSpacing: 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Products Section
            LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = MediaQuery.of(context).size.width;
                final padding = screenWidth < 600 ? 16.0 : 40.0;
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Padding(
                        padding: EdgeInsets.all(padding),
                        child: Column(
                          children: [
                            Text(
                              'ESSENTIAL RANGE - OVER 20% OFF!',
                              style: TextStyle(
                                fontSize: screenWidth < 600 ? 16 : 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                letterSpacing: 1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            // Essential Range Products (2 products)
                            Center(
                              child: Wrap(
                                spacing: 16,
                                runSpacing: 24,
                                alignment: WrapAlignment.center,
                                children: [
                                  SizedBox(
                                    width: screenWidth < 600
                                        ? screenWidth - 32
                                        : 350,
                                    height: 320,
                                    child: const ProductCard(
                                      title: 'Placeholder Product 1',
                                      price: '£10.00',
                                      imageUrl:
                                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth < 600
                                        ? screenWidth - 32
                                        : 350,
                                    height: 320,
                                    child: const ProductCard(
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
                            Text(
                              'SIGNATURE RANGE',
                              style: TextStyle(
                                fontSize: screenWidth < 600 ? 16 : 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                letterSpacing: 1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            // Signature Range Products (2 products)
                            Center(
                              child: Wrap(
                                spacing: 16,
                                runSpacing: 24,
                                alignment: WrapAlignment.center,
                                children: [
                                  SizedBox(
                                    width: screenWidth < 600
                                        ? screenWidth - 32
                                        : 350,
                                    height: 320,
                                    child: const ProductCard(
                                      title: 'Placeholder Product 3',
                                      price: '£20.00',
                                      imageUrl:
                                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth < 600
                                        ? screenWidth - 32
                                        : 350,
                                    height: 320,
                                    child: const ProductCard(
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
                            Text(
                              'PORTSMOUTH CITY COLLECTION',
                              style: TextStyle(
                                fontSize: screenWidth < 600 ? 16 : 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                letterSpacing: 1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            // Portsmouth City Collection Products (4 products)
                            Center(
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 732),
                                child: Wrap(
                                  spacing: 16,
                                  runSpacing: 24,
                                  alignment: WrapAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: screenWidth < 600
                                          ? screenWidth - 32
                                          : 350,
                                      height: 320,
                                      child: ProductCard(
                                        title: 'Portsmouth City Product 1',
                                        price: '£12.00',
                                        imageUrl:
                                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth < 600
                                          ? screenWidth - 32
                                          : 350,
                                      height: 320,
                                      child: const ProductCard(
                                        title: 'Portsmouth City Product 2',
                                        price: '£16.00',
                                        imageUrl:
                                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth < 600
                                          ? screenWidth - 32
                                          : 350,
                                      height: 320,
                                      child: const ProductCard(
                                        title: 'Portsmouth City Product 3',
                                        price: '£14.00',
                                        imageUrl:
                                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth < 600
                                          ? screenWidth - 32
                                          : 350,
                                      height: 320,
                                      child: const ProductCard(
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
                            Text(
                              'OUR RANGE',
                              style: TextStyle(
                                fontSize: screenWidth < 600 ? 16 : 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                letterSpacing: 1,
                              ),
                              textAlign: TextAlign.center,
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
                                _buildCategoryCard(context, 'CLOTHING'),
                                _buildCategoryCard(context, 'MERCHANDISE'),
                                _buildCategoryCard(context, 'GRADUATION'),
                                _buildCategoryCard(context, 'SALE'),
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
                                      Center(
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            maxWidth: 300,
                                            maxHeight: 300,
                                          ),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                // Uncomment and add image URL to display image:
                                                // image: const DecorationImage(
                                                //   image: NetworkImage('YOUR_IMAGE_URL_HERE'),
                                                //   fit: BoxFit.cover,
                                                // ),
                                              ),
                                            ),
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
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ProductPage(),
                                                ),
                                              );
                                            },
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
                                    ],
                                  );
                                } else {
                                  // Desktop layout: Text on left, image on right
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Text and button side
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 40),
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
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ProductPage(),
                                                    ),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xFF4d2963),
                                                  foregroundColor: Colors.white,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 40,
                                                    vertical: 16,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
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
                                        child: Center(
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              maxWidth: 350,
                                              maxHeight: 350,
                                            ),
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  // Uncomment and add image URL to display image:
                                                  // image: const DecorationImage(
                                                  //   image: NetworkImage('YOUR_IMAGE_URL_HERE'),
                                                  //   fit: BoxFit.cover,
                                                  // ),
                                                ),
                                              ),
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
