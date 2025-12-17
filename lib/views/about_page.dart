import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_navbar.dart';
import 'package:union_shop/widgets/app_footer.dart';
import 'package:union_shop/views/personalisation.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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

            // About Us content
            LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = MediaQuery.of(context).size.width;
                final padding = screenWidth < 600 ? 16.0 : 40.0;
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(padding),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'About Us',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF424242)),
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'Welcome to the Union Shop!',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF424242)),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Color(0xFF424242),
                              ),
                              children: [
                                const TextSpan(
                                  text:
                                      'We\'re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive ',
                                ),
                                TextSpan(
                                  text: 'personalisation service',
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ProductPage(),
                                        ),
                                      );
                                    },
                                ),
                                const TextSpan(text: '!'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'All online purchases are available for delivery or instore collection!',
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Color(0xFF424242)),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don\'t hesitate to contact us at hello@upsu.net.',
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Color(0xFF424242)),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Happy shopping!',
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Color(0xFF424242)),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'The Union Shop & Reception Team',
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF424242)),
                            textAlign: TextAlign.left,
                          ),
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
}
