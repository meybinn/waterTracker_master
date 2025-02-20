import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  factory DatabaseHelper() => instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await getDatabase();
    return _database!;
  }

  Future<Database> getDatabase() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      String path = join(dir.path, 'water_tracker.db');
      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT NOT NULL,
          email TEXT UNIQUE NOT NULL,
          password TEXT NOT NULL,
          age INTEGER,
          gender TEXT,
          weight REAL,
          height REAL,
          water_goal INTEGER 
          ); 
          ''');

          await db.execute('''
          CREATE TABLE water_intake(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id TEXT,
          TOtalIntake INTEGER,
          timestamp TEXT,
          FOREIGN KEY(user_id) REFERENCES users(id) on delete cascade
          );
        ''');

          await db.execute('''
          CREATE TABLE setting (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id TEXT ,
          interval INTEGER,
          from_time TEXT,
          to_time TEXT,
          FOREIGN KEY(user_id) REFERENCES users(id) on delete cascade
          );
        ''');
        },
      );
    } catch (e) {
      print("Database creation error in $e");
      rethrow;
    }
  }

  Future<int> getTotalIntake(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'water_intake',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    int total =
        result.fold(0, (sum, item) => sum + (item['TotalIntake'] as int));
    return total;
  }

  Future<List<Map<String, dynamic>>> getHistory(String userId) async {
    final db = await database;
    return await db.query(
      'water_intake',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'timestamp DESC',
    );
  }

  Future<void> closeDatabase() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
