import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:database_flutter/models/note_model.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper getInstance = DbHelper._();

  static final String TABLE_NOTE = "note";
  static final String COLUMN_NOTE_SNO = "s_no";
  static final String COLUMN_NOTE_TITLE = "title";
  static final String COLUMN_NOTE_DESC = "desc";

  Database? myDB;

  Future <Database> getDB ()async{
    if(myDB!=null){
      return myDB!;
    } else{
      myDB = await opendb();
      return myDB!;
    }

  }
 Future <Database> opendb()async{
   Directory appDirectory = await getApplicationDocumentsDirectory();
 String dbpath = join(appDirectory.path,"noteDB.db");
 return await openDatabase(dbpath,onCreate: (db,version){
 db.execute("Create table $TABLE_NOTE ($COLUMN_NOTE_SNO integer primary key autoincrement,$COLUMN_NOTE_TITLE text,$COLUMN_NOTE_DESC text)");
 },version: 1);

  }
/// insertion
  Future<bool> addNote(NoteModel note) async {
    var db = await getDB();

    int rowEffected = await db.insert(
      TABLE_NOTE,
      note.toMap(),
    );

    return rowEffected > 0;
  }

// Reading All Data
  Future<List<NoteModel>> getAllNotes() async {
    var db = await getDB();

    List<Map<String, dynamic>> data =
    await db.query(TABLE_NOTE);

    return data.map((e) => NoteModel.fromMap(e)).toList();
  }
// Updation part.....
  Future<bool> updateNote(NoteModel note) async {
    var db = await getDB();

    int rowEffected = await db.update(
      TABLE_NOTE,
      note.toMap(),
      where: "$COLUMN_NOTE_SNO = ?",
      whereArgs: [note.id],
    );

    return rowEffected > 0;
  }
// Deletion part.....
  Future<bool> deleteNote({required int Sno}) async {
    var db = await getDB();

    int rowEffected = await db.delete(
      TABLE_NOTE,
      where: "$COLUMN_NOTE_SNO = ?",
      whereArgs: [Sno],
    );

    return rowEffected > 0;
  }

  }
