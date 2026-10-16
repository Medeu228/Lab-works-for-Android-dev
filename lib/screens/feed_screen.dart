import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_tile.dart';
import 'detail_screen.dart';

class FeedScreen extends StatelessWidget {
  final Set<int> favoriteIds;
  final void Function(int id) onToggleFavorite;

  const FeedScreen({
    super.key,
    required this.favoriteIds,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: ListView.builder(
        itemCount: sampleProducts.length,
        itemBuilder: (context, index) {
          final product = sampleProducts[index];
          return ProductTile(
            product: product,
            isFavorite: favoriteIds.contains(product.id),
            onToggleFavorite: () => onToggleFavorite(product.id),
            onTap: () {
              // Navigator.push with arguments: the full Product object goes
              // straight into DetailScreen's constructor (title, description,
              // icon/image, price, category — everything at once).
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    product: product,
                    isFavorite: favoriteIds.contains(product.id),
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
