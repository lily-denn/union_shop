import 'package:flutter/material.dart';
import 'package:union_shop/views/product_page.dart';
import 'package:union_shop/views/about_page.dart';
import 'package:union_shop/views/home_page.dart';
import 'package:union_shop/views/print_shack_about.dart';
import 'package:union_shop/views/collections_page.dart';
import 'package:union_shop/views/sign_in.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(),
      // By default, the app starts at the '/' route, which is the HomeScreen
      initialRoute: '/',
      // When navigating to '/product', build and return the ProductPage
      // In your browser, try this link: http://localhost:49856/#/product
      routes: {
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutPage(),
        '/print_shack': (context) => const PrintShackPage(),
        '/collections': (context) => const CollectionsPage(),
        '/sign_in': (context) => const SignInPage(),
      },
    );
  }
}
