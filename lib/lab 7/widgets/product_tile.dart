import 'package:flutter/material.dart';
import '../models/product.dart';

// Reusable list row, shared by the Feed and Favorites tabs so the two
// screens don't duplicate the same layout code.
class ProductTile extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTap;

  const ProductTile({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple[50],
          child: Icon(product.icon, color: Colors.deepPurple),
        ),
        title: Text(product.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('\$${product.price.toStringAsFixed(2)} · ${product.category}'),
        trailing: IconButton(
          onPressed: onToggleFavorite,
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
          ),
        ),
      ),
    );
  }
}
