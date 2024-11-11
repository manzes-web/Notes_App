import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

class NoteDetails extends StatelessWidget {
  final Note notes;
  const NoteDetails({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notes.text),
      ),
      body: Center(
        child: Text(notes.description),
      ),
    );
  }
}
