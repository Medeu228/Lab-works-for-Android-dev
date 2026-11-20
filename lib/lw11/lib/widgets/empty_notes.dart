import 'package:flutter/material.dart';

/// Shown when the notes list is empty.
class EmptyNotes extends StatelessWidget {
  const EmptyNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final grey = Theme.of(context).colorScheme.outline;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.sticky_note_2_outlined, size: 48, color: grey),
            const SizedBox(height: 8),
            Text('No notes yet - add the first one!',
                style: TextStyle(color: grey)),
          ],
        ),
      ),
    );
  }
}
