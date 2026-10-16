import 'package:flutter/material.dart';
import '../models/product.dart';

class DetailScreen extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const DetailScreen({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar already shows a working back arrow automatically, because
      // this screen was reached via Navigator.push — tapping it calls
      // Navigator.pop() for you, no extra code needed.
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(product.icon, size: 80, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(height: 24),
            Text(product.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(product.category, style: const TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(product.description, style: const TextStyle(fontSize: 15, height: 1.5)),
            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onToggleFavorite,
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                label: Text(isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
              ),
            ),
            const SizedBox(height: 12),

            // Explicit in-body back button, in addition to the AppBar's own.
            // Both call Navigator.pop(context) — this just removes the
            // current route from the stack and returns to Feed/Favorites
            // exactly as it was (scroll position, favorites state and all),
            // it does not rebuild or restart that screen.
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
