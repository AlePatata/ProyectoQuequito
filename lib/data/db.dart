import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:quequitos/data/model_queque.dart';


class DBHelper {
  static final DBHelper instance = DBHelper._instanciate();
  static Database? _database;

  DBHelper._instanciate();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'queques.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE queques('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'done TEXT, sold INTEGER, '
              'flavor TEXT, '
              'charged INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<int> insertQueque(ModelQueque queque) async {
    final Database db = await instance.database;

    return await db.insert(
      'queques',
      queque.toMap(),
    );
  }

  Future<List<ModelQueque>> getAllQueques() async {
    final Database db = await instance.database;
    final quequesMap = await db.query('queques');

    return quequesMap.map((json) => ModelQueque.fromMap(json)).toList();
  }

  Future<void> updateQueque(ModelQueque queque) async {
    final db = await database;

    await db.update(
      'queques',
      queque.toMap(),
      where: 'id = ?',
      whereArgs: [queque.id],
    );
  }

  Future<int> deleteQueque(int id) async {
    final db = await instance.database;
    return await db.delete('queques', where: 'id = ?', whereArgs: [id]);
  }


}


