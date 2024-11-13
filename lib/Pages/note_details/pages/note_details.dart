import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/Pages/note_page.dart';
import 'package:notes_app/Pages/widgets/delete_dialog.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/routes/routes.dart';

class NoteDetails extends StatelessWidget {
  final Note notes;
  const NoteDetails({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(notes.text),
        actions: [
          PopupMenuButton(
            surfaceTintColor: Theme.of(context).colorScheme.primary,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    context.pushNamed(Routes.noteUpdate.name, extra: notes);
                  },
                  child: const Text('update'),
                ),
                PopupMenuItem(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => DeleteDialog(id: notes.id),
                  ),
                  child: const Text('Delete'),
                ),
              ];
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  notes.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Assigned date : ${notes.dateTime}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
