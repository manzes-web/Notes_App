import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Themes/theme_provider.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  ThemeProvider themeProvider = ThemeProvider();
  @override
  void initState() {
    super.initState();
    readNotes();
  }

  final textController = TextEditingController();
  void createNote() {
    // textController.clear();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
                cursorColor: Theme.of(context).colorScheme.inversePrimary,
                decoration: InputDecoration(
                  labelText: 'Enter Note..',
                  labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                  focusColor: Theme.of(context).colorScheme.inversePrimary,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                ),
              ),
              title: const Text('ADD NOTES'),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context
                        .read<NoteDatabase>()
                        .createNote(textController.text);
                    Navigator.pop(context);
                    textController.clear();
                  },
                  child: const Text('ADD'),
                )
              ],
            ));
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void readNotes() {
    context.read<NoteDatabase>().readNote();
  }

  void updateNotes(Note note) {
    textController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('UPDATE NOTE'),
              content: TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: 'Update Note..',
                  labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                  focusColor: Theme.of(context).colorScheme.inversePrimary,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context
                        .read<NoteDatabase>()
                        .updateNote(note.id, textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Update'),
                )
              ],
            ));
  }

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> notes = noteDatabase.notes;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text(
          'NOTES',
        ),
        leading: const Icon(
          Icons.menu,
        ),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Row(
                children: [
                  Icon(
                    themeProvider.isDarkMode
                        ? Icons.dark_mode
                        : Icons.light_mode,
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
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return Card(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              color: Theme.of(context).colorScheme.inversePrimary,
              child: ListTile(
                title: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${index + 1}'.toString(),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        note.text,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.background),
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
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                    IconButton(
                      onPressed: () => deleteNote(note.id),
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red.shade300,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(eccentricity: 1),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: createNote,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
