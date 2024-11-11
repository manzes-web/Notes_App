import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/Pages/widgets/apptextfield.dart';
import 'package:notes_app/models/note_database.dart';

class DeleteDialog extends ConsumerWidget {
  final int id;
  const DeleteDialog({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = TextEditingController();
    final descriptionController = TextEditingController();
    return AlertDialog(
      title: const Text('Delete note'),
      content: const Text('Are you sure want to delete note?'),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
            textController.clear();
            descriptionController.clear();
          },
          child: const Text('No'),
        ),
        MaterialButton(
          onPressed: () {
            ref.read(noteDatabaseProvider.notifier).deleteNote(id);
            Navigator.pop(context);
            textController.clear();
            descriptionController.clear();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
