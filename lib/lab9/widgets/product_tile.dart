import 'package:flutter/material.dart';

import '../models/product.dart';
import 'category_badge.dart';
import 'product_image.dart';
import 'rating_stars.dart';

/// One row of the feed: thumbnail · title · category · rating · price.
class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // the same Hero tag as on the detail screen -> the picture
            // "flies" from the list to the carousel
            Hero(
              tag: 'product_image_${product.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 72,
                  height: 72,
                  child: ProductImage(
                    url: product.imageUrl,
                    padding: const EdgeInsets.all(6),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      CategoryBadge(category: product.category),
                      RatingStars(
                        rating: product.rating,
                        reviewCount: product.reviewCount,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.formattedPrice,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
