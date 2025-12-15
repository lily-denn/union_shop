import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_navbar.dart';
import 'package:union_shop/widgets/app_footer.dart';

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
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(40.0),
              child: const Center(
                child: Text(
                  'About Us',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
