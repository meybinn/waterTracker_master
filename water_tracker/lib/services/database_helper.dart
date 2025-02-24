import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  factory DatabaseHelper() => instance;
  static Database? _database;

  DatabaseHelper._internal();

// database 초기화
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await getDatabase();
    return _database!;
  }

// DB 구축
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
          id TEXT PRIMARY KEY ,
          username TEXT NOT NULL,
          email TEXT UNIQUE NOT NULL,
          password TEXT NOT NULL,
          age INTEGER,   
          gender TEXT,
          weight REAL,
          height REAL
          ); 
          ''');

          await db.execute('''
          CREATE TABLE water_intake(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id TEXT,
          amount INTEGER,
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
          intakeGoal INTEGER,
          FOREIGN KEY(user_id) REFERENCES users(id) on delete cascade
          );
        ''');
        },
      );
    } catch (e) {
      print("Error in $e during database creation!");
      rethrow;
    }
  }

// SignUpScreen 기능 : insert
  Future<int> insertUser(String username, String email, String password) async {
    final db = await database;
    var uuid = Uuid();
    String userId = uuid.v4();

    return await db.insert(
      'users',
      {
        // 'id': userId,
        'username': username,
        'email': email,
        'password': password,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// SignUpScreen 기능 : check email&password
  Future<Map<String, dynamic>?> checkUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // SetUpScreen 기능 : insert
  Future<int> updateUserInfo(String userId, int age, String gender,
      double weight, double height) async {
    final db = await database;
    return await db.update(
      'users',
      {
        'age': age,
        'gender': gender,
        'weight': weight,
        'height': height,
      },
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

// setUpGoalScreen 기능 : insert
  Future<int> insertOrUpdateGoal(String userId, int intakeGoal,
      TimeOfDay fromTime, TimeOfDay toTime, int interval) async {
    final db = await database;

    // 기존 목표 확인
    final existing = await db.query(
      'setting',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (existing.isNotEmpty) {
      // 기존 목표 업데이트
      return await db.update(
        'setting',
        {
          'intakeGoal': intakeGoal,
          'from_time': '${fromTime.hour}:${fromTime.minute}',
          'to_time': '${toTime.hour}:${toTime.minute}',
          'interval': interval,
        },
        where: 'user_id = ?',
        whereArgs: [userId],
      );
    } else {
      // 새로운 목표 추가
      return await db.insert(
        'setting',
        {
          'user_id': userId,
          'intakeGoal': intakeGoal,
          'from_time': '${fromTime.hour}:${fromTime.minute}',
          'to_time': '${toTime.hour}:${toTime.minute}',
          'interval': interval,
        },
      );
    }
  }

// home screen 기능 : intakeGoal&amount&timestamp 표기
  Future<Map<String, dynamic>?> getHomeData(String userId) async {
    final db = await database;

    // 총 섭취량 계산
    String today = DateTime.now().toIso8601String().split('T')[0];
    final List<Map<String, dynamic>> intakeResult = await db.query(
      'water_intake',
      where: 'user_id = ? AND timestamp LIKE ?',
      whereArgs: [userId, '$today%'],
    );

    int totalIntake =
        intakeResult.fold(0, (sum, item) => sum + (item['amount'] as int));

    // 목표량 가져오기
    final List<Map<String, dynamic>> goalResult = await db.query(
      'setting',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (goalResult.isNotEmpty) {
      return {
        'intakeGoal': goalResult.first['intakeGoal'],
        'totalIntake': totalIntake,
      };
    }

    return null;
  }

// history screen : timestamp&amount 표기
  Future<List<Map<String, dynamic>>> getHistory(String userId) async {
    final db = await database;
    return await db.query(
      'water_intake',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'timestamp DESC',
    );
  }

// add intake screen 기능 : update
  Future<int> addWaterIntake(String userId, int amount) async {
    final db = await database;
    return await db.insert(
      'water_intake',
      {
        'user_id': userId,
        'amount': amount,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

// reset intake
  Future<void> resetWaterIntake(String userId) async {
    final db = await database;

    // 오늘 날짜로 필터링하여 해당 사용자의 섭취 기록 삭제
    String today = DateTime.now().toIso8601String().split('T')[0];
    await db.delete(
      'water_intake',
      where: 'user_id = ? AND timestamp LIKE ?',
      whereArgs: [userId, '$today%'],
    );
  }

// get user settings
  Future<Map<String, dynamic>?> getUserSetting(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'setting',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return result.isNotEmpty ? result.first : null;
  }

// saveGoalScreen 기능 : update
  Future<int> updateGoal(String userId, int intakeGoal, String fromTime,
      String toTime, int interval) async {
    final db = await database;
    return await db.update(
      'setting',
      {
        'intakeGoal': intakeGoal,
        'fromTime': fromTime,
        'toTime': toTime,
        'interval': interval,
      },
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

// setting screen 기능 : gender&age&weight&height 표기
  Future<Map<String, dynamic>?> getUserSettings(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
    return result.isNotEmpty ? result.first : null;
  }

//closing database
  Future<void> closeDatabase() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }

//setting screen 기능: 업데이트
  Future<int> updateUserSettings(String userId, int age, String gender,
      double weight, double height, int intakeGoal) async {
    final db = await database;
    return await db.update(
      'users',
      {
        'age': age,
        'gender': gender,
        'weight': weight,
        'height': height,
      },
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

// 전체 intake  get
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

// // history screen 닫기
//   Future<List<Map<String, dynamic>>> getHistory(int userId) async {
//     final db = await database;
//     return await db.query(
//       'water_intake',
//       where: 'user_id = ?',
//       whereArgs: [userId],
//       orderBy: 'timestamp DESC',
//     );
//   }

// // DB 닫기
//   Future<void> closeDatabase() async {
//     final db = _database;
//     if (db != null) {
//       await db.close();
//     }
//   }

// // 물 섭취 기록 insert
//   Future<int> insertWaterIntake(int userId, int amount) async {
//     final db = await database;
//     return await db.insert(
//       'water_intake',
//       {
//         'user_id': userId,
//         'TotalIntake': amount,
//         'timestamp': DateTime.now().toIso8601String(),
//       },
//       // 매개변수를 뺴고 현재 시간이 저장되도록 변경
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

// // 오늘 섭취량 get
//   Future<int> getTodayTotalIntake(int userId) async {
//     final db = await database;
//     String today =
//         DateTime.now().toIso8601String().split('T')[0]; // 오늘 날짜만 가져오기
//     final List<Map<String, dynamic>> result = await db.query(
//       'water_intake',
//       where: 'user_id = ? AND timestamp LIKE ?',
//       whereArgs: [userId, '$today%'], // 오늘 날짜로 시작하는 데이터만 필터링
//     );

//     int total =
//         result.fold(0, (sum, item) => sum + (item['TotalIntake'] as int));
//     return total;
//   }

//   // setting 화면 속 get
//   Future<Map<String, dynamic>?> getUserSetting(int userId) async {
//     final db = await database;
//     final List<Map<String, dynamic>> result = await db.query(
//       'setting',
//       where: 'user_id = ?',
//       whereArgs: [userId],
//     );

//     if (result.isNotEmpty) {
//       return result.first; // 첫 번째 결과 반환
//     }
//     return null; // 데이터가 없으면 null 반환
//   }
//
}
