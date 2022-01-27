import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todos/data/models/todo_models.dart';

class DatabaseHelper {
  static Database _db;
  final String table = 'produk';
  final String id = 'id';
  final String title = 'title';
  final String total = 'qty';
  final String userId = 'userId';

  static final DatabaseHelper _instanse = DatabaseHelper.internal();
  factory DatabaseHelper() => _instanse;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDB();
    return _db;
  }

  initDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'toko.db');
    var localDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return localDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $table (userId INTEGER, id INTEGER PRIRY KEY, title TEXT, qty INTEGER, completed TEXT)");
  }

  Future<int> insert(TodoModels todo) async {
    var dbClient = await db;
    var data = await dbClient.insert('$table', todo.toJson());
    return data;
  }

  Future<TodoModels> getData() async {
    var dbClient = await db;
    List<Map> map = await dbClient.rawQuery("SELECT * FROM $table");
    if (map.length > 0) {
      return TodoModels.fromJson(map.last);
    }
    return null;
  }

  Future<int> deleteData(int key) async {
    var dbClient = await db;
    return await dbClient.delete(table, where: '$id = ?', whereArgs: [key]);
  }
}
