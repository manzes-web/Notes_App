import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/Pages/widgets/apptextfield.dart';
import 'package:notes_app/Pages/widgets/delete_dialog.dart';
import 'package:notes_app/Pages/widgets/dialogbox.dart';
import 'package:notes_app/Themes/theme_provider.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:notes_app/routes/routes.dart';

class NotePage extends ConsumerStatefulWidget {
  const NotePage({super.key});

  @override
  ConsumerState<NotePage> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NotePage> {
  final textController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch notes when the page is initialized
    readNotes();
  }

  @override
  void dispose() {
    textController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // Fetch notes from the database
  void readNotes() {
    ref.read(noteDatabaseProvider.notifier).fetchNotes();
  }

  // Create a new note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          cursorColor: Theme.of(context).colorScheme.inversePrimary,
          decoration: InputDecoration(
            labelText: 'Enter Note..',
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
            focusColor: Theme.of(context).colorScheme.inversePrimary,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary)),
          ),
        ),
        title: const Text('ADD NOTES'),
        actions: [
          MaterialButton(
            onPressed: () {
              // Call createNote method from NoteDatabase provider
              ref.read(noteDatabaseProvider.notifier).createNote(textController.text, descriptionController.text);
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text('ADD'),
          )
        ],
      ),
    );
  }

  // Update an existing note
  void updateNotes(Note note) {
    textController.text = note.text;
    descriptionController.text = note.description;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('UPDATE NOTE'),
        // content: TextField(
        //   controller: textController,
        //   decoration: InputDecoration(
        //     labelText: 'Update Note..',
        //     labelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        //     focusColor: Theme.of(context).colorScheme.inversePrimary,
        //     border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary)),
        //     focusedBorder: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary)),
        //   ),
        // ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Apptextfield(
              textController: textController,
              labelText: 'Update note title...',
            ),
            const SizedBox(
              height: 8,
            ),
            Apptextfield(
              textController: descriptionController,
              labelText: 'Update note description...',
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              // Call updateNote method from NoteDatabase provider
              ref.read(noteDatabaseProvider.notifier).updateNote(note.id, textController.text, descriptionController.text);
              textController.clear();
              descriptionController.clear();
              Navigator.pop(context);
            },
            child: const Text('Update'),
          )
        ],
      ),
    );
  }

  // Delete a note
  void deleteNote(int id) {
    ref.read(noteDatabaseProvider.notifier).deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final asyncNotes = ref.watch(noteDatabaseProvider);
    final themeProvider = ref.read(themeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('NOTES'),
        leading: const Icon(Icons.menu),
        actions: [
          Row(
            children: [
              Icon(
                themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              CupertinoSwitch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
                activeColor: Colors.green,
              ),
            ],
          ),
        ],
      ),
      body: asyncNotes.when(
        data: (notes) {
          return ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return InkWell(
                onTap: () => context.pushNamed(
                  Routes.noteDetails.name,
                  extra: note,
                ),
                child: Card(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  color: Theme.of(context).colorScheme.inversePrimary,
                  child: ListTile(
                    title: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            shape: BoxShape.circle,
                          ),
                          child: Text('${index + 1}'),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            note.text,
                            style: TextStyle(color: Theme.of(context).colorScheme.surface),
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => updateNotes(note),
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        IconButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => DeleteDialog(id: note.id),
                          ),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red.shade300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(eccentricity: 1),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const Dialogbox(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
