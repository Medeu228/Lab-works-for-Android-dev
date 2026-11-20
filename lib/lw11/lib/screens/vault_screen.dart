import 'package:flutter/material.dart';

import '../models/note_item.dart';
import '../services/storage_service.dart';
import '../widgets/empty_notes.dart';
import '../widgets/note_input.dart';
import '../widgets/note_tile.dart';
import '../widgets/profile_header.dart';
import '../widgets/section_card.dart';
import '../widgets/username_editor.dart';

/// The single screen of the app: header, settings, profile, notes.
class VaultScreen extends StatefulWidget {
  const VaultScreen({
    super.key,
    required this.storage,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  final StorageService storage;
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  @override
  State<VaultScreen> createState() => _VaultScreenState();
}

class _VaultScreenState extends State<VaultScreen> {
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();

  late String _userName;
  late List<NoteItem> _notes;

  @override
  void initState() {
    super.initState();
    // SharedPreferences was already loaded in main(), so these reads are
    // synchronous: data is on screen in the first frame, no spinner needed.
    _userName = widget.storage.loadUserName();
    _notes = widget.storage.loadNotes();
    if (_userName != StorageService.defaultUserName) {
      _nameController.text = _userName;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  // ---------- Username ----------

  Future<void> _saveUserName() async {
    FocusScope.of(context).unfocus();
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      // empty field = forget the name -> header falls back to 'Guest User'
      await widget.storage.clearUserName();
      if (!mounted) return;
      setState(() => _userName = StorageService.defaultUserName);
      _showSnack('Name cleared - showing "${StorageService.defaultUserName}"');
      return;
    }

    await widget.storage.saveUserName(name);
    if (!mounted) return;
    setState(() => _userName = name);
    _showSnack('Saved: $name');
  }

  // ---------- Notes CRUD ----------

  /// Every change goes through here: update the screen, then write the
  /// WHOLE list to disk as one JSON string.
  Future<void> _updateNotes(List<NoteItem> updated) async {
    setState(() => _notes = updated);
    await widget.storage.saveNotes(updated);
  }

  void _addNote() {
    final title = _noteController.text.trim();
    if (title.isEmpty) return;
    _noteController.clear();
    // prepend: the new note goes to index 0 (top of the list)
    _updateNotes([NoteItem.create(title), ..._notes]);
  }

  void _toggleNote(NoteItem note) {
    _updateNotes([
      for (final n in _notes)
        n.id == note.id ? n.copyWith(isCompleted: !n.isCompleted) : n,
    ]);
  }

  void _deleteNote(NoteItem note) {
    _updateNotes(_notes.where((n) => n.id != note.id).toList());
    _showSnack('Deleted: ${note.title}');
  }

  void _showSnack(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final doneCount = _notes.where((n) => n.isCompleted).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Notes & Settings Vault')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          ProfileHeader(
            userName: _userName,
            totalNotes: _notes.length,
            doneNotes: doneCount,
          ),
          const SizedBox(height: 12),

          SectionCard(
            title: 'Settings',
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: Icon(
                widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
              title: const Text('Dark Mode'),
              subtitle: Text(widget.isDarkMode ? 'On' : 'Off'),
              value: widget.isDarkMode,
              onChanged: widget.onDarkModeChanged,
            ),
          ),
          const SizedBox(height: 12),

          SectionCard(
            title: 'Profile',
            child: UsernameEditor(
              controller: _nameController,
              onSave: _saveUserName,
            ),
          ),
          const SizedBox(height: 12),

          SectionCard(
            title: 'Notes (${_notes.length})',
            child: Column(
              children: [
                NoteInput(controller: _noteController, onAdd: _addNote),
                const SizedBox(height: 8),
                if (_notes.isEmpty)
                  const EmptyNotes()
                else
                  for (final note in _notes)
                    NoteTile(
                      key: ValueKey(note.id),
                      note: note,
                      onToggle: () => _toggleNote(note),
                      onDelete: () => _deleteNote(note),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
