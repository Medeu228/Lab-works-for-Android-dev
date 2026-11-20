/// One note in the vault.
///
/// On disk the whole list is stored as ONE JSON string, e.g.:
/// [
///   {"id":"1763..","title":"Buy milk","dateText":"20.11.2026 14:05","isCompleted":false},
///   {"id":"1763..","title":"Lab 11","dateText":"20.11.2026 13:40","isCompleted":true}
/// ]
class NoteItem {
  final String id;
  final String title;
  final String dateText;
  final bool isCompleted;

  const NoteItem({
    required this.id,
    required this.title,
    required this.dateText,
    this.isCompleted = false,
  });

  /// A brand-new note: unique id from the clock + formatted creation date.
  factory NoteItem.create(String title) {
    final now = DateTime.now();
    return NoteItem(
      id: now.microsecondsSinceEpoch.toString(),
      title: title,
      dateText: formatDate(now),
    );
  }

  /// Objects are immutable, so "toggle" = make a copy with one field changed.
  NoteItem copyWith({String? title, bool? isCompleted}) {
    return NoteItem(
      id: id,
      title: title ?? this.title,
      dateText: dateText,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  /// Dart object -> Map (jsonEncode can only encode Map/List/String/num/bool/null).
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'dateText': dateText,
      'isCompleted': isCompleted,
    };
  }

  /// Map (from jsonDecode) -> Dart object. Null-safe: a missing or broken
  /// field gets a default instead of crashing the app on startup.
  factory NoteItem.fromJson(Map<String, dynamic> json) {
    return NoteItem(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? 'Untitled note',
      dateText: json['dateText'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  /// 20.11.2026 14:05
  static String formatDate(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.day)}.${two(d.month)}.${d.year} ${two(d.hour)}:${two(d.minute)}';
  }
}
