import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/category_badge.dart';
import '../widgets/image_carousel.dart';
import '../widgets/rating_stars.dart';
import '../widgets/share_link_sheet.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  void _addToCart(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('"${product.title}" added to cart')),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Product'),
        actions: [
          IconButton(
            tooltip: 'Share',
            onPressed: () => showShareLinkSheet(context, product),
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: ListView(
        children: [
          // photo carousel (first slide = Hero target)
          AspectRatio(
            aspectRatio: 1,
            child: ImageCarousel(
              images: product.galleryImages,
              heroTag: 'product_image_${product.id}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CategoryBadge(category: product.category),
                ),
                const SizedBox(height: 10),
                Text(
                  product.title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                RatingStars(
                  rating: product.rating,
                  reviewCount: product.reviewCount,
                  size: 18,
                ),
                const SizedBox(height: 16),
                Text(
                  'Description',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  product.description,
                  style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
      // sticky bottom bar: price + "Add to Cart" taking the rest of the width
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            children: [
              Text(
                product.formattedPrice,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _addToCart(context),
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Add to Cart'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
