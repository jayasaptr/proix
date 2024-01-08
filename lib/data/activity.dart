
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseActivity {
  DatabaseActivity._private();

  static final DatabaseActivity instance = DatabaseActivity._private();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'activity.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE header (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT,
        name TEXT,
        created_at TEXT,
        updated_at TEXT,
        deleted_at TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE detail (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT,
        date TEXT,
        time TEXT,
        before TEXT,
        action TEXT,
        after TEXT,
        recommend_action TEXT,
        created_at TEXT,
        updated_at TEXT,
        deleted_at TEXT,
        header_id INTEGER,
        FOREIGN KEY (header_id) REFERENCES header (id)
      )
    ''');
  }

  Future closeDB() async {
    _database = await instance.database;
    _database!.close();
  }
}