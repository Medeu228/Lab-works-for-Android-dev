import 'package:flutter/material.dart';

import '../data/catalog_data.dart';
import '../models/product.dart';
import 'category_tag.dart';
import 'star_rating.dart';

/// One cell of the 2-column Grid view.
/// The cell size is fixed by childAspectRatio: 0.72, so the icon area is
/// Expanded (takes whatever height is left) and every Text has maxLines —
/// nothing can push the card past its height -> no RenderFlex overflow.
class ProductGridCard extends StatelessWidget {
  const ProductGridCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Color.lerp(product.color, Colors.white, 0.85),
              alignment: Alignment.center,
              child: Icon(product.icon, size: 48, color: product.color),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (product.isNew) ...[
                      const CategoryTag(label: 'NEW', color: Colors.green),
                      const SizedBox(width: 4),
                    ],
                    Flexible(
                      child: CategoryTag(
                        label: product.category,
                        color: product.color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: StarRating(rating: product.rating, size: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  formatPrice(product.price),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
