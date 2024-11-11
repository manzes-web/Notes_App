import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/Pages/widgets/apptextfield.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

class Dialogbox extends ConsumerWidget {
  const Dialogbox({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = TextEditingController();
    final descriptionController = TextEditingController();
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Apptextfield(
            textController: textController,
            labelText: 'Enter note title...',
          ),
          const SizedBox(
            height: 8,
          ),
          Apptextfield(
            textController: descriptionController,
            labelText: 'Enter note description...',
          ),
        ],
      ),
      title: const Text('ADD NOTES'),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
            textController.clear();
            descriptionController.clear();
          },
          child: const Text('CANCEL'),
        ),
        MaterialButton(
          onPressed: () {
            ref.read(noteDatabaseProvider.notifier).createNote(textController.text, descriptionController.text);
            Navigator.pop(context);
            textController.clear();
            descriptionController.clear();
          },
          child: const Text('ADD'),
        ),
      ],
    );
  }
}
