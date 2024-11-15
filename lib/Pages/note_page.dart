import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/Pages/widgets/delete_dialog.dart';
import 'package:notes_app/Themes/theme_provider.dart';
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
                activeColor: Theme.of(context).colorScheme.primary,
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
                  color: Theme.of(context).colorScheme.primary,
                  child: ListTile(
                    title: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            note.text,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => context.pushNamed(
                            Routes.noteUpdate.name,
                            extra: note,
                          ),
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.inversePrimary,
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
        onPressed: () => context.pushNamed(Routes.noteAdd.name),
        child: const Icon(Icons.add),
      ),
    );
  }
}
