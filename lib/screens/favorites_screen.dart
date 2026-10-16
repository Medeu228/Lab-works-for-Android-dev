import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_tile.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final Set<int> favoriteIds;
  final void Function(int id) onToggleFavorite;

  const FavoritesScreen({
    super.key,
    required this.favoriteIds,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final favorites = sampleProducts.where((p) => favoriteIds.contains(p.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.isEmpty
          ? const Center(
              child: Text('No favorites yet — tap the heart on an item in Feed'),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ProductTile(
                  product: product,
                  isFavorite: true,
                  onToggleFavorite: () => onToggleFavorite(product.id),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          product: product,
                          isFavorite: true,
                          onToggleFavorite: () => onToggleFavorite(product.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
