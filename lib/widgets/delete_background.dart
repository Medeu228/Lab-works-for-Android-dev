import 'package:flutter/material.dart';

/// Red background revealed under an item while it is swiped right-to-left.
class DeleteBackground extends StatelessWidget {
  const DeleteBackground({super.key, this.borderRadius = 0});

  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }
}
