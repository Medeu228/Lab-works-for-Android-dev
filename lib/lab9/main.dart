import 'package:flutter/material.dart';

import 'screens/product_list_screen.dart';

void main() {
  runApp(const ProductExplorerApp());
}

class ProductExplorerApp extends StatelessWidget {
  const ProductExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Product Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const ProductListScreen(),
    );
  }
}
