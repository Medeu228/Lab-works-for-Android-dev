import 'package:flutter/material.dart';

/// ★★★★☆ 3.9 (120)
class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.size = 14,
  });

  final double rating;
  final int reviewCount;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= 5; i++)
          Icon(
            rating >= i
                ? Icons.star
                : rating >= i - 0.5
                ? Icons.star_half
                : Icons.star_border,
            size: size,
            color: Colors.amber.shade700,
          ),
        const SizedBox(width: 4),
        Text(
          '${rating.toStringAsFixed(1)} ($reviewCount)',
          style: TextStyle(fontSize: size - 1, color: Colors.grey.shade700),
        ),
      ],
    );
  }
}
