import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/Pages/note_page.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:notes_app/routes/routes.dart';

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
      shadowColor: Theme.of(context).colorScheme.inversePrimary,
      elevation: 0.5,
      backgroundColor: Theme.of(context).colorScheme.primary,
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

            textController.clear();
            descriptionController.clear();
            context.pushNamed(Routes.home.name);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
