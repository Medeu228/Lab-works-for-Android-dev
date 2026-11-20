import 'package:flutter/material.dart';

/// TextField + "add" button for a new note. Enter on the keyboard also adds.
class NoteInput extends StatelessWidget {
  const NoteInput({super.key, required this.controller, required this.onAdd});

  final TextEditingController controller;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => onAdd(),
      decoration: InputDecoration(
        hintText: 'Write a new note...',
        border: const OutlineInputBorder(),
        isDense: true,
        suffixIcon: IconButton(
          tooltip: 'Add note',
          icon: const Icon(Icons.add_circle),
          onPressed: onAdd,
        ),
      ),
    );
  }
}
