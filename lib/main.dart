import 'package:flutter/material.dart';

import 'screens/catalog_screen.dart';

void main() {
  runApp(const SmartCatalogApp());
}

class SmartCatalogApp extends StatelessWidget {
  const SmartCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const CatalogScreen(),
    );
  }
}
