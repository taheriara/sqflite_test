import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_test/models/question_model.dart';

class DBProvider {
  static final DBProvider db = DBProvider._init();
  static Database? _database;

  DBProvider._init();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await _initDB('faq_manager.db');

    return _database!;
  }

  // Create the database and the Employee table
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    //-Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //-final path = join(documentsDirectory.path, 'faq_manager.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
          CREATE TABLE faq(
          faqid INTEGER PRIMARY KEY,
          question TEXT,
          answer TEXT,
          creationTime TEXT,
          favorite INTEGER
          )
          ''');
  }

  // Insert question on database
  createQuestion(QuestionModel newQuestion) async {
    await deleteAllQuestion();
    final db = await database;
    final res = await db.insert('faq', newQuestion.toJson());
    print('inserted*****************************');
    return res;
  }

  // Delete all employees
  Future<int> deleteAllQuestion() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM faq');

    return res;
  }

  // Delete one employees
  Future<int> deleteOneQuestion(int i) async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM faq where faqid=$i');

    return res;
  }

  Future<List<QuestionModel>> getAllQuestion() async {
    final db = await database;
    //final res = await db.rawQuery("SELECT * FROM FAQ");
    final res = await db.query('faq');

    List<QuestionModel> list = res.isNotEmpty
        ? res.map((c) => QuestionModel.fromJson(c)).toList()
        : [];
    print('getALLL: ${res.length}');
    return list;
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
