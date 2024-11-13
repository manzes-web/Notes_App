import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/Pages/widgets/apptextfield.dart';
import 'package:notes_app/Pages/widgets/datetime_textfield.dart';
import 'package:notes_app/models/note_database.dart';

class Dialogbox extends ConsumerWidget {
  final String? title;
  final String? labelTextTitle;
  final String? labelTextDescription;
  const Dialogbox({
    super.key,
    this.labelTextDescription,
    this.labelTextTitle,
    this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = TextEditingController();
    final descriptionController = TextEditingController();
    final dateController = TextEditingController();

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Apptextfield(
            textController: textController,
            labelText: '$labelTextTitle',
          ),
          const SizedBox(
            height: 12,
          ),
          Apptextfield(
            textController: descriptionController,
            labelText: '$labelTextDescription',
          ),
          const SizedBox(
            height: 12,
          ),
          DatetimeTextfield(
            dateController: dateController,
          ),
        ],
      ),
      title: Text('$title'),
      actions: [
        MaterialButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            Navigator.pop(context);
            textController.clear();
            descriptionController.clear();
          },
          child: const Text('CANCEL'),
        ),
        MaterialButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            ref.read(noteDatabaseProvider.notifier).createNote(textController.text, descriptionController.text, dateController.text);
            Navigator.pop(context);
            textController.clear();
            descriptionController.clear();
            dateController.clear();
          },
          child: const Text('ADD'),
        ),
      ],
    );
  }
}
