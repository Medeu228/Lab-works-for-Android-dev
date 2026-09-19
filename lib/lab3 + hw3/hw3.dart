abstract class MediaItem {
  String id;
  String title;
  double price;

  MediaItem({required this.id, required this.title, required this.price});

  String getDetails();
}

mixin Downloadable {
  void download(String title) {
    print('Downloading "$title"...');
  }
}

class Audiobook extends MediaItem with Downloadable {
  double durationHours;
  String narrator;

  Audiobook({
    required super.id,
    required super.title,
    required super.price,
    required this.durationHours,
    required this.narrator,
  });

  @override
  String getDetails() =>
      'Audiobook: "$title" narrated by $narrator, ${durationHours}h, \$${price.toStringAsFixed(2)}';
}

class EBook extends MediaItem with Downloadable {
  double fileSizeMB;
  String author;

  EBook({
    required super.id,
    required super.title,
    required super.price,
    required this.fileSizeMB,
    required this.author,
  });

  @override
  String getDetails() =>
      'EBook: "$title" by $author, ${fileSizeMB}MB, \$${price.toStringAsFixed(2)}';
}

class ShoppingCart {
  final List<MediaItem> _items = [];

  void addItem(MediaItem item) {
    _items.add(item);
  }

  double calculateTotalWithTax({double taxRate = 0.12}) {
    final double subtotal = _items.fold(0.0, (double sum, MediaItem item) => sum + item.price);
    return subtotal + subtotal * taxRate;
  }

  List<MediaItem> filterByMaxPrice(double maxPrice) {
    return _items.where((item) => item.price <= maxPrice).toList();
  }

  void printReceipt() {
    print('--- Receipt ---');
    for (final item in _items) {
      print(item.getDetails());
      if (item is Downloadable) {
        (item as Downloadable).download(item.title);
      }
    }
    print('Total (incl. 12% tax): \$${calculateTotalWithTax().toStringAsFixed(2)}');
  }
}

void main() {
  final cart = ShoppingCart();

  cart.addItem(Audiobook(
    id: 'A1',
    title: 'Atomic Habits',
    price: 14.99,
    durationHours: 5.5,
    narrator: 'James Clear',
  ));

  cart.addItem(EBook(
    id: 'E1',
    title: 'Dart Essentials',
    price: 9.99,
    fileSizeMB: 3.2,
    author: 'Google Dart Team',
  ));

  cart.addItem(EBook(
    id: 'E2',
    title: 'Advanced Flutter',
    price: 24.99,
    fileSizeMB: 5.8,
    author: 'Jane Doe',
  ));

  cart.printReceipt();

  print('\n--- Items under \$15 ---');
  for (final item in cart.filterByMaxPrice(15.0)) {
    print(item.getDetails());
  }
}