/// One product from https://fakestoreapi.com/products
///
/// Example of one JSON object from the API:
/// {
///   "id": 1,
///   "title": "Fjallraven - Foldsack No. 1 Backpack",
///   "price": 109.95,
///   "description": "...",
///   "category": "men's clothing",
///   "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
///   "rating": { "rate": 3.9, "count": 120 }
/// }
class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviewCount;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
  });

  /// Null-safe + numeric-safe factory.
  ///
  /// Numbers in JSON can arrive as int OR double: "price": 22 and
  /// "price": 22.3 are both valid. `json['price'] as double` would crash on
  /// 22, so every number is read as `num` first and then converted with
  /// .toDouble() / .toInt(). Missing fields (null) fall back to defaults
  /// instead of throwing.
  factory Product.fromJson(Map<String, dynamic> json) {
    // "rating" is a nested object; if it's missing or broken, use {}
    final rawRating = json['rating'];
    final ratingJson = rawRating is Map<String, dynamic>
        ? rawRating
        : const <String, dynamic>{};

    return Product(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? 'Untitled product',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? 'No description.',
      category: json['category'] as String? ?? 'other',
      imageUrl: json['image'] as String? ?? '',
      rating: (ratingJson['rate'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (ratingJson['count'] as num?)?.toInt() ?? 0,
    );
  }

  /// The API gives one photo per product. The carousel shows 3 slides
  /// built from it (full view / zoomed / detail), so swiping, the page
  /// counter and the dots can be demonstrated.
  List<String> get galleryImages => [imageUrl, imageUrl, imageUrl];

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
}
