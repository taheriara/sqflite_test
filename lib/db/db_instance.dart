import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_test/models/question_model.dart';

class DbInstance {
  final String _dbName = 'my_database';
  final int _dbVersion = 1;

  static Database? _database;
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    return openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    //const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const idType = 'INTEGER PRIMARY KEY';

    await db.execute('''
    CREATE TABLE question (
      faqId $idType,
      question TEXT NOT NULL,
      answer TEXT NOT NULL,
      creationTime TEXT NOT NULL,
      favorite INTEGER NOT NULL,      
    )
    ''');
  }

  Future<List<QuestionModel>> all() async {
    final data = await _database!.query('question');
    List<QuestionModel> result =
        data.map((e) => QuestionModel.fromJson(e)).toList();
    return result;
  }
}
