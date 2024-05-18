import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes_app/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initialize() async {
    //INITIALIZATION OF THE DATABASE
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  //CREATING A NEW LIST OF  NOTES
  final List<Note> notes = [];

  //CREATING A NEW NOTE
  Future<void> createNote(String inputText) async {
    if (inputText.isNotEmpty) {
      final newNote = Note()..text = inputText;

      await isar.writeTxn(() => isar.notes.put(newNote));
    }

    readNote();
  }

//READING A NOTE
  Future<void> readNote() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    notes.clear();
    notes.addAll(fetchNotes);
    notifyListeners();
  }

  //UPDATING A NOTE
  Future<void> updateNote(int id, String text) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = text;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      readNote();
    }
  }

  //DELETING A NOTE
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await readNote();
  }
}
