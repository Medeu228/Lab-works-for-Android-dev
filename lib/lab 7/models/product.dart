import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final IconData icon;
  final double price;
  final String category;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.price,
    required this.category,
  });
}

// sample data for the Feed tab — swap for a real API/DB later
const List<Product> sampleProducts = [
  Product(
    id: 1,
    title: 'Wireless Headphones',
    description:
        'Over-ear Bluetooth headphones with active noise cancellation and 30h battery life.',
    icon: Icons.headphones,
    price: 149.99,
    category: 'Audio',
  ),
  Product(
    id: 2,
    title: 'Smart Watch',
    description:
        'Fitness tracking, heart-rate monitor, 7-day battery, waterproof up to 50m.',
    icon: Icons.watch,
    price: 199.00,
    category: 'Wearables',
  ),
  Product(
    id: 3,
    title: 'Running Shoes',
    description:
        'Lightweight running shoes with breathable mesh and responsive cushioning.',
    icon: Icons.directions_run,
    price: 89.50,
    category: 'Footwear',
  ),
  Product(
    id: 4,
    title: 'Mechanical Keyboard',
    description:
        'Hot-swappable mechanical keyboard with RGB backlight and USB-C.',
    icon: Icons.keyboard,
    price: 119.00,
    category: 'Electronics',
  ),
];
