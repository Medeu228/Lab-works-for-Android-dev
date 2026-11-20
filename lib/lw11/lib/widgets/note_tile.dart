import 'package:flutter/material.dart';

import '../models/note_item.dart';

/// One note: checkbox (toggle), title, date, delete button.
class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.note,
    required this.onToggle,
    required this.onDelete,
  });

  final NoteItem note;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final grey = Theme.of(context).colorScheme.outline;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onToggle,
      leading: Checkbox(
        value: note.isCompleted,
        onChanged: (_) => onToggle(),
      ),
      title: Text(
        note.title,
        style: TextStyle(
          decoration: note.isCompleted ? TextDecoration.lineThrough : null,
          color: note.isCompleted ? grey : null,
        ),
      ),
      subtitle: Text(note.dateText),
      trailing: IconButton(
        tooltip: 'Delete',
        icon: const Icon(Icons.delete_outline),
        onPressed: onDelete,
      ),
    );
  }
}
