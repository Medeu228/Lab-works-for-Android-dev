class Book {
  String title;
  String author;
  double price;
  bool isBorrowed;

  Book({
    required this.title,
    required this.author,
    required this.price,
    this.isBorrowed = false,
  });
}

class Library {
  final List<Book> _books = [];

  void addBook(Book book) {
    _books.add(book);
  }

  List<Book> getAvailableBooks() {
    return _books.where((book) => book.isBorrowed == false).toList();
  }

  double getTotalValue() {
    return _books.fold(0.0, (double sum, Book book) => sum + book.price);
  }
}

void main() {
  final library = Library();

  library.addBook(Book(title: 'Clean Code', author: 'Robert C. Martin', price: 25.5));
  library.addBook(Book(title: 'Dart in Action', author: 'Chris Buckett', price: 18.0, isBorrowed: true));
  library.addBook(Book(title: 'Flutter for Beginners', author: 'Alessandro Biessek', price: 22.0));
  library.addBook(Book(title: 'Effective Dart', author: 'Google', price: 15.75, isBorrowed: true));

  print('--- Available books ---');
  for (final book in library.getAvailableBooks()) {
    print('${book.title} by ${book.author} — \$${book.price.toStringAsFixed(2)}');
  }

  print('\nTotal collection value: \$${library.getTotalValue().toStringAsFixed(2)}');
}