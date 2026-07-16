import 'package:flutter/material.dart';
import 'package:database_flutter/data/local/DB_helper.dart';
import 'package:database_flutter/models/note_model.dart';

class DbProvider extends ChangeNotifier {
  final DbHelper dbHelper;

  DbProvider({required this.dbHelper}) {
    getInitialNotes();
  }

  List<NoteModel> _notes = [];

  List<NoteModel> get notes => _notes;

  Future<void> getInitialNotes() async {
    _notes = await dbHelper.getAllNotes();
    notifyListeners();
  }

  Future<void> addNote(NoteModel note) async {
    bool check = await dbHelper.addNote(note);

    if (check) {
      await getInitialNotes();
    }
  }

  Future<void> updateNote(NoteModel note) async {
    bool check = await dbHelper.updateNote(note);

    if (check) {
      await getInitialNotes();
    }
  }

  Future<void> deleteNote(int id) async {
    bool check = await dbHelper.deleteNote(Sno: id);

    if (check) {
      await getInitialNotes();
    }
  }
}