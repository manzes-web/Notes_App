import 'package:isar/isar.dart';
import 'package:notes_app/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note_database.g.dart';

@riverpod
class NoteDatabase extends _$NoteDatabase {
  static late Isar isar;

  @override
  Future<List<Note>> build() async {
    // Initialize the database asynchronously on first access
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
    return fetchNotes(); // Return the initial list of notes
  }

  // Fetch notes from the database
  Future<List<Note>> fetchNotes() async {
    try {
      final notes = await isar.notes.where().findAll();
      state = AsyncData(notes);
      return notes;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return []; // Return an empty list in case of an error
    }
  }

  // Create a new note
  Future<void> createNote(String inputText, String descriptionText, String date) async {
    if (inputText.isNotEmpty) {
      final noteText = Note()..text = inputText;
      final noteDescription = noteText..description = descriptionText;
      final newNote = noteDescription..dateTime = date;
      await isar.writeTxn(() => isar.notes.put(newNote));
      await fetchNotes(); // Refresh notes list
    }
  }

  // Update a note
  Future<void> updateNote(int id, String text, String description) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = text;
      existingNote.description = description;

      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes(); // Refresh notes list
    }
  }

  // Delete a note
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes(); // Refresh notes list
  }
}
