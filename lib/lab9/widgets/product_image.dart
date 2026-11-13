import 'package:flutter/material.dart';

/// Network image with a spinner while loading and an icon if it fails.
class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.url,
    this.fit = BoxFit.contain,
    this.padding = EdgeInsets.zero,
  });

  final String url;
  final BoxFit fit;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: padding,
      child: url.isEmpty
          ? const _Placeholder()
          : Image.network(
              url,
              fit: fit,
              width: double.infinity,
              height: double.infinity,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) =>
                  const _Placeholder(),
            ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey.shade400,
      ),
    );
  }
}
