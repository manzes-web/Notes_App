import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/Pages/widgets/app_primary_button.dart';
import 'package:notes_app/Pages/widgets/apptextfield.dart';
import 'package:notes_app/Pages/widgets/datetime_textfield.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/routes/routes.dart';

class AddNote extends ConsumerStatefulWidget {
  const AddNote({
    super.key,
  });

  @override
  ConsumerState<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends ConsumerState<AddNote> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

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
    void addNote() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('Update note'),
          content: const Text('Are you sure want to add this note?'),
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
                ref.read(noteDatabaseProvider.notifier).createNote(
                      textController.text,
                      descriptionController.text,
                      dateController.text,
                    );
                textController.clear();
                descriptionController.clear();
                // context.pop();
                context.pushNamed(Routes.home.name);
              },
              child: const Text('Add'),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Add NOTE'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Apptextfield(
              textController: textController,
              labelText: 'Add title..',
            ),
            const SizedBox(height: 12),
            Apptextfield(
              textController: descriptionController,
              labelText: 'Add description...',
            ),
            const SizedBox(height: 12),
            DatetimeTextfield(
              dateController: dateController,
            ),
            const SizedBox(
              height: 12,
            ),
            AppPrimaryButton(
              onTap: () => addNote(),
              buttonText: 'Add',
            ),
          ],
        ),
      ),
    );
  }
}
