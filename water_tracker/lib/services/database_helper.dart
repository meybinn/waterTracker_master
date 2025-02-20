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
          user_id INTEGER,
          TotalIntake INTEGER,
          timestamp TEXT,
          FOREIGN KEY(user_id) REFERENCES users(id) on delete cascade
          );
        ''');

          await db.execute('''
          CREATE TABLE setting (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER ,
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

  Future<int> getTotalIntake(int userId) async {
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

// history screen 닫기기
  Future<List<Map<String, dynamic>>> getHistory(int userId) async {
    final db = await database;
    return await db.query(
      'water_intake',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'timestamp DESC',
    );
  }

// DB 닫기기
  Future<void> closeDatabase() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }

// 물 섭취 기록
  Future<int> insertWaterIntake(int userId, int amount) async {
    final db = await database;
    return await db.insert(
      'water_intake',
      {
        'user_id': userId,
        'TotalIntake': amount,
        'timestamp': DateTime.now().toIso8601String(),
      },
      // 매개변수를 뺴고 현재 시간이 저장되도록 변경
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// 오늘 섭취량
  Future<int> getTodayTotalIntake(int userId) async {
    final db = await database;
    String today =
        DateTime.now().toIso8601String().split('T')[0]; // 오늘 날짜만 가져오기
    final List<Map<String, dynamic>> result = await db.query(
      'water_intake',
      where: 'user_id = ? AND timestamp LIKE ?',
      whereArgs: [userId, '$today%'], // 오늘 날짜로 시작하는 데이터만 필터링
    );

    int total =
        result.fold(0, (sum, item) => sum + (item['TotalIntake'] as int));
    return total;
  }
}
