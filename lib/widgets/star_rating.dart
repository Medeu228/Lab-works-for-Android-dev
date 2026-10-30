import 'package:flutter/material.dart';

/// 4.6 -> ★★★★½ 4.6
class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.rating, this.size = 14});

  final double rating;
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
          rating.toStringAsFixed(1),
          style: TextStyle(fontSize: size - 2, color: Colors.grey.shade700),
        ),
      ],
    );
  }
}
