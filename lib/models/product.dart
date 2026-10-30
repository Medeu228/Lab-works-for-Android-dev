import 'package:flutter/material.dart';

/// One catalog item.
/// `id` must be unique — Dismissible uses it as ValueKey(product.id).
class Product {
  final int id;
  final String title;
  final String category;
  final double rating; // 0.0 – 5.0
  final int price; // tenge
  final IconData icon;
  final Color color;
  final bool isNew; // true for items added by pull-to-refresh

  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.rating,
    required this.price,
    required this.icon,
    required this.color,
    this.isNew = false,
  });
}
