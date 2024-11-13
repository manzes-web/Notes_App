import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/Pages/widgets/app_primary_button.dart';
import 'package:notes_app/Pages/widgets/apptextfield.dart';
import 'package:notes_app/Pages/widgets/datetime_textfield.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/routes/routes.dart';

class NoteUpdate extends ConsumerStatefulWidget {
  final Note notes;
  const NoteUpdate({
    super.key,
    required this.notes,
  });

  @override
  ConsumerState<NoteUpdate> createState() => _NoteUpdateState();
}

class _NoteUpdateState extends ConsumerState<NoteUpdate> {
  late final TextEditingController textController;
  late final TextEditingController descriptionController;
  late final TextEditingController dateController;
  @override
  void initState() {
    textController = TextEditingController(text: widget.notes.text);
    descriptionController = TextEditingController(text: widget.notes.description);
    dateController = TextEditingController(text: widget.notes.dateTime);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Update an existing note
    void updateNotes(Note note) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('Update note'),
          content: const Text('Are you sure want to Update note?'),
          actions: [
            MaterialButton(
              onPressed: () {
                textController.clear();
                descriptionController.clear();
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            MaterialButton(
              onPressed: () {
                // Call updateNote method from NoteDatabase provider
                ref.read(noteDatabaseProvider.notifier).updateNote(note.id, textController.text, descriptionController.text);
                textController.clear();
                descriptionController.clear();
                // context.pop();
                context.pushNamed(Routes.home.name);
              },
              child: const Text('Update'),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('UPDATE NOTE'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Apptextfield(
              textController: textController,
              labelText: 'Update title..',
            ),
            const SizedBox(height: 12),
            Apptextfield(
              textController: descriptionController,
              labelText: 'Update description...',
            ),
            const SizedBox(height: 12),
            DatetimeTextfield(
              dateController: dateController,
            ),
            const SizedBox(
              height: 12,
            ),
            AppPrimaryButton(
              onTap: () => updateNotes(widget.notes),
              buttonText: 'Update',
            ),
          ],
        ),
      ),
    );
  }
}
