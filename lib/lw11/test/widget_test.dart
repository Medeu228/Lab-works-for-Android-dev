// Replaces the default counter test from `flutter create`.
// Works when the project is named lw11 (flutter create lw11).
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lw11/main.dart';
import 'package:lw11/models/note_item.dart';
import 'package:lw11/services/storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('NoteItem survives toJson -> fromJson', () {
    const note = NoteItem(
      id: '1',
      title: 'Lab 11',
      dateText: '20.11.2026 14:05',
      isCompleted: true,
    );
    final copy = NoteItem.fromJson(note.toJson());
    expect(copy.id, '1');
    expect(copy.title, 'Lab 11');
    expect(copy.dateText, '20.11.2026 14:05');
    expect(copy.isCompleted, true);
  });

  test('fromJson uses fallbacks for missing fields', () {
    final note = NoteItem.fromJson({'id': 5});
    expect(note.id, '5');
    expect(note.title, 'Untitled note');
    expect(note.isCompleted, false);
  });

  test('notes are saved as one JSON string and restored', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final storage = StorageService(prefs);

    await storage.saveNotes([
      NoteItem.create('First'),
      NoteItem.create('Second').copyWith(isCompleted: true),
    ]);

    expect(prefs.getString(StorageService.notesKey), isA<String>());
    final restored = StorageService(prefs).loadNotes();
    expect(restored.length, 2);
    expect(restored[1].isCompleted, true);
  });

  testWidgets('first launch shows Guest User', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      VaultApp(storage: StorageService(prefs), initialDarkMode: false),
    );
    expect(find.text('Guest User'), findsOneWidget);
  });

  testWidgets('saved dark mode is applied on the first frame', (tester) async {
    SharedPreferences.setMockInitialValues({StorageService.darkModeKey: true});
    final prefs = await SharedPreferences.getInstance();
    final storage = StorageService(prefs);
    await tester.pumpWidget(
      VaultApp(storage: storage, initialDarkMode: storage.loadDarkMode()),
    );
    final context = tester.element(find.byType(Scaffold));
    expect(Theme.of(context).brightness, Brightness.dark);
  });
}
