import 'dart:math';

import 'package:flutter/material.dart';

import '../models/product.dart';

/// Initial catalog. Returns a NEW list every time, so "Reset Catalog"
/// can restore it even after every item was swiped away.
List<Product> seedProducts() => [
  const Product(
    id: 1,
    title: 'Wireless Headphones',
    category: 'Audio',
    rating: 4.6,
    price: 24990,
    icon: Icons.headphones,
    color: Colors.indigo,
  ),
  const Product(
    id: 2,
    title: 'Smart Watch',
    category: 'Wearables',
    rating: 4.3,
    price: 64000,
    icon: Icons.watch,
    color: Colors.teal,
  ),
  const Product(
    id: 3,
    title: 'Running Sneakers',
    category: 'Sports',
    rating: 4.8,
    price: 32990,
    icon: Icons.directions_run,
    color: Colors.deepOrange,
  ),
  const Product(
    id: 4,
    title: 'Laptop Air 14',
    category: 'Electronics',
    rating: 4.7,
    price: 389990,
    icon: Icons.laptop_mac,
    color: Colors.blueGrey,
  ),
  const Product(
    id: 5,
    title: 'Instant Camera',
    category: 'Hobbies',
    rating: 4.1,
    price: 38000,
    icon: Icons.photo_camera,
    color: Colors.pink,
  ),
  const Product(
    id: 6,
    title: 'City Backpack',
    category: 'Accessories',
    rating: 4.4,
    price: 17990,
    icon: Icons.backpack,
    color: Colors.brown,
  ),
  const Product(
    id: 7,
    title: 'Thermo Mug 450 ml',
    category: 'Home',
    rating: 3.9,
    price: 6990,
    icon: Icons.coffee,
    color: Colors.amber,
  ),
  const Product(
    id: 8,
    title: 'LED Desk Lamp',
    category: 'Home',
    rating: 4.2,
    price: 9990,
    icon: Icons.light,
    color: Colors.orange,
  ),
  const Product(
    id: 9,
    title: 'Mechanical Keyboard',
    category: 'Electronics',
    rating: 4.9,
    price: 32000,
    icon: Icons.keyboard,
    color: Colors.deepPurple,
  ),
  const Product(
    id: 10,
    title: 'Bluetooth Speaker',
    category: 'Audio',
    rating: 4.0,
    price: 19990,
    icon: Icons.speaker,
    color: Colors.cyan,
  ),
  const Product(
    id: 11,
    title: 'Road Bike',
    category: 'Sports',
    rating: 4.5,
    price: 95000,
    icon: Icons.pedal_bike,
    color: Colors.green,
  ),
  const Product(
    id: 12,
    title: 'Programming Books Set',
    category: 'Books',
    rating: 4.7,
    price: 15000,
    icon: Icons.menu_book,
    color: Colors.red,
  ),
];

/// Makes random "new arrivals" for pull-to-refresh.
/// Ids start at 1000 and only grow, so they never clash with the seed
/// ids — every Dismissible keeps a unique ValueKey.
class ProductGenerator {
  final _random = Random();
  int _nextId = 1000;

  static const _templates = [
    ('Gaming Mouse', 'Electronics', Icons.mouse, Colors.deepPurple),
    ('Yoga Mat', 'Sports', Icons.self_improvement, Colors.green),
    ('Sunglasses', 'Accessories', Icons.wb_sunny, Colors.orange),
    (
      'Power Bank 20000',
      'Electronics',
      Icons.battery_charging_full,
      Colors.teal,
    ),
    ('Desk Plant', 'Home', Icons.local_florist, Colors.lightGreen),
    ('Earbuds Pro', 'Audio', Icons.earbuds, Colors.indigo),
    ('Board Game', 'Hobbies', Icons.casino, Colors.pink),
    ('Novel Bestseller', 'Books', Icons.auto_stories, Colors.red),
  ];

  Product next() {
    final t = _templates[_random.nextInt(_templates.length)];
    final id = _nextId++;
    return Product(
      id: id,
      title: '${t.$1} #$id',
      category: t.$2,
      rating: (30 + _random.nextInt(21)) / 10, // 3.0 – 5.0
      price: (5 + _random.nextInt(96)) * 1000, // 5 000 – 100 000 ₸
      icon: t.$3,
      color: t.$4,
      isNew: true,
    );
  }
}

/// 24990 -> "24 990 ₸"
String formatPrice(int price) {
  final digits = price.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    buffer.write(digits[i]);
    final left = digits.length - i - 1;
    if (left > 0 && left % 3 == 0) buffer.write(' ');
  }
  return '$buffer ₸';
}
