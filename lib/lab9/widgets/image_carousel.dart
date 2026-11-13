import 'package:flutter/material.dart';

import 'product_image.dart';

/// Swipeable photo gallery: PageView.builder + "1 / 3" counter +
/// animated dots. The first page is wrapped in Hero, so the picture from
/// the list lands exactly here.
class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key, required this.images, required this.heroTag});

  final List<String> images;
  final String heroTag;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // The API has one photo per product, so the 3 slides show it in
  // different ways: full product / zoomed in / close-up detail.
  static const _fits = [BoxFit.contain, BoxFit.cover, BoxFit.fitHeight];
  static const _paddings = [
    EdgeInsets.all(32),
    EdgeInsets.zero,
    EdgeInsets.all(8),
  ];

  @override
  Widget build(BuildContext context) {
    final count = widget.images.length;
    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: count,
          onPageChanged: (index) => setState(() => _page = index),
          itemBuilder: (context, index) {
            final image = ProductImage(
              url: widget.images[index],
              fit: _fits[index % _fits.length],
              padding: _paddings[index % _paddings.length],
            );
            return index == 0 ? Hero(tag: widget.heroTag, child: image) : image;
          },
        ),

        // page counter "1 / 3"
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0x99000000),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${_page + 1} / $count',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        // animated dots: the active one stretches into a pill
        Positioned(
          left: 0,
          right: 0,
          bottom: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < count; i++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == _page ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == _page
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
