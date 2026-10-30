import 'package:flutter/material.dart';

import '../data/catalog_data.dart';
import '../models/product.dart';
import 'category_tag.dart';
import 'star_rating.dart';

/// One row of the List view: avatar icon · title · category tag · stars · price
class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Color.lerp(product.color, Colors.white, 0.8),
            child: Icon(product.icon, color: product.color),
          ),
          const SizedBox(width: 12),
          // Expanded: the middle column takes the free width, so a long
          // title is cut with "…" instead of overflowing the Row
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (product.isNew)
                      const CategoryTag(label: 'NEW', color: Colors.green),
                    CategoryTag(label: product.category, color: product.color),
                    StarRating(rating: product.rating),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            formatPrice(product.price),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
