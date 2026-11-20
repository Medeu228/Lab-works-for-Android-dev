import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/note_item.dart';

/// The only class that knows about SharedPreferences.
/// Screens call simple methods and never deal with keys or JSON.
class StorageService {
  StorageService(this._prefs);

  final SharedPreferences _prefs;

  // Keys from the task specification
  static const darkModeKey = 'app_theme_dark_mode';
  static const userNameKey = 'user_display_name';
  static const notesKey = 'notes_list_json';

  static const defaultUserName = 'Guest User';

  // ---------- 1. Theme (bool) ----------

  /// `?? false` -> first launch (nothing saved yet) = light theme.
  bool loadDarkMode() => _prefs.getBool(darkModeKey) ?? false;

  Future<void> saveDarkMode(bool isDarkMode) async {
    await _prefs.setBool(darkModeKey, isDarkMode);
  }

  // ---------- 2. Username (String) ----------

  /// `?? 'Guest User'` -> fallback when no name was saved.
  String loadUserName() => _prefs.getString(userNameKey) ?? defaultUserName;

  Future<void> saveUserName(String name) async {
    await _prefs.setString(userNameKey, name);
  }

  /// Removes the key, so loadUserName() falls back to 'Guest User'.
  Future<void> clearUserName() async {
    await _prefs.remove(userNameKey);
  }

  // ---------- 3. Notes (List<NoteItem> as ONE JSON string) ----------

  /// List<NoteItem> -> List<Map> (toJson) -> String (jsonEncode) -> disk.
  Future<void> saveNotes(List<NoteItem> notes) async {
    final jsonList = notes.map((note) => note.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _prefs.setString(notesKey, jsonString);
  }

  /// disk -> String -> List<dynamic> (jsonDecode) -> List<NoteItem> (fromJson).
  /// Corrupted data never crashes the app: we just start with an empty list.
  List<NoteItem> loadNotes() {
    final jsonString = _prefs.getString(notesKey);
    if (jsonString == null || jsonString.isEmpty) return [];

    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is! List) return [];
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(NoteItem.fromJson)
          .toList();
    } on FormatException {
      return [];
    }
  }
}
