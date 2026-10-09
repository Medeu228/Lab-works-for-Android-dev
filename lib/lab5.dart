// LAB 5: Adaptive E-Commerce Item Detail Screen
// - Stack: cover image + bookmark badge
// - Row + Wrap: title, rating, price, category badges
// - Sticky bottom bar: Add to Cart button filling remaining width via Expanded
// - Overflow-proofed for small AND large screens (see comments marked ANTI-OVERFLOW)
//
// This file replaces lib/main.dart in a Flutter project (flutter create my_app).

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Detail',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
      home: const ProductDetailScreen(),
    );
  }
}

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isBookmarked = false;

  void _toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ANTI-OVERFLOW: SingleChildScrollView lets content taller than the
      // screen (small phones, big font scale) scroll instead of overflowing
      // vertically.
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----- Stack: cover image + bookmark badge -----
            Stack(
              children: [
                Container(
                  // ANTI-OVERFLOW: width: double.infinity scales with the
                  // screen instead of a fixed pixel width that would
                  // overflow horizontally on a narrow phone.
                  width: double.infinity,
                  height: 280,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple[200]!, Colors.deepPurple[400]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.shopping_bag_outlined, size: 100, color: Colors.white),
                  ),
                  // swap the Container above for your real image, e.g.:
                  // Image.network('https://...', width: double.infinity, height: 280, fit: BoxFit.cover)
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: _toggleBookmark,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: isBookmarked ? Colors.deepPurple : Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ----- title -----
                  const Text(
                    'Wireless Noise-Cancelling Headphones',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // ----- rating + price -----
                  Row(
                    children: [
                      // ANTI-OVERFLOW: Flexible lets the rating shrink/wrap
                      // instead of pushing the price off-screen on a narrow
                      // phone; mainAxisSize.min keeps it from eating all
                      // the Row's space on a wide/tablet screen.
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                '4.8 (320 reviews)',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        '\$149.99',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ----- category badges -----
                  // ANTI-OVERFLOW: Wrap moves badges to a new line instead
                  // of forcing them into one Row and overflowing
                  // horizontally once there isn't enough width left.
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _Badge(label: 'Electronics'),
                      _Badge(label: 'Audio'),
                      _Badge(label: 'Free Shipping'),
                      _Badge(label: 'Best Seller'),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Industry-leading noise cancellation with up to 30 hours of battery life. '
                    'Comfortable over-ear design, built-in microphone, Bluetooth 5.2.',
                    style: TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
                  ),
                  const SizedBox(height: 100), // room above the sticky bar
                ],
              ),
            ),
          ],
        ),
      ),

      // ----- sticky bottom action bar -----
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: const Offset(0, -2))],
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: _toggleBookmark,
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? Colors.deepPurple : Colors.grey[700],
                ),
              ),
              const SizedBox(width: 8),
              // ANTI-OVERFLOW: Expanded makes the button fill whatever
              // width remains — a small phone or a tablet, it never has
              // a fixed width that could overflow the Row.
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart')),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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

class _Badge extends StatelessWidget {
  final String label;
  const _Badge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.deepPurple[100]!),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, color: Colors.deepPurple[700], fontWeight: FontWeight.w500),
      ),
    );
  }
}
