import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_navbar.dart';
import 'package:union_shop/widgets/app_footer.dart';

class PrintShackPage extends StatelessWidget {
  const PrintShackPage({super.key});

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

            // Print Shack content
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'The Union Print Shack',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF616161)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      // Centered image
                      Center(
                        child: Image.network(
                          'https://cdn.shopify.com/s/files/1/0226/4599/7643/files/The_Union_Print_Shack_Logo_-_Personalisation.png?v=1760535658',
                          height: 200,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              width: 300,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.print,
                                    size: 80, color: Colors.grey),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 48),
                      const Text(
                        'Make It Yours at The Union Print Shack',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF616161)),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Want to add a personal touch? We\'ve got you covered with heat-pressed customisation on all our clothing. Swing by the shop - our team\'s always happy to help you pick the right gear and answer any questions.',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Color(0xFF616161)),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Uni Gear or Your Gear - We\'ll Personalise It',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF616161)),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Whether you\'re repping your university or putting your own spin on a hoodie you already own, we\'ve got you covered. We can personalise official uni-branded clothing and your own items - just bring them in and let\'s get creative!',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Color(0xFF616161)),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Simple Pricing, No Surprises',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF616161)),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Customising your gear won\'t break the bank - just £3 for one line of text or a small chest logo, and £5 for two lines or a large back logo. Turnaround time is up to three working days, and we\'ll let you know as soon as it\'s ready to collect.',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Color(0xFF616161)),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Personalisation Terms & Conditions',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF616161)),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'We will print your clothing exactly as you have provided it to us, whether online or in person. We are not responsible for any spelling errors. Please ensure your chosen text is clearly displayed in either capitals or lowercase. Refunds are not provided for any personalised items.',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Color(0xFF616161)),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Ready to Make It Yours?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF616161)),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Pop in or get in touch today - let\'s create something uniquely you with our personalisation service - The Union Print Shack!',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Color(0xFF616161)),
                        textAlign: TextAlign.left,
                      ),
                    ],
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
