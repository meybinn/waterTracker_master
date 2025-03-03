import 'package:flutter/material.dart';
import 'package:water_tracker/services/database_helper.dart';

class IntakeProvider with ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  final Map<DateTime, List<String>> _intakeHistory = {};

  bool _isNotification = false;

  String _userId = "";

  int _totalIntake = 0;
  String _username = " ";
  String _gender = "";
  String _age = "";
  String _height = "";
  String _weight = "";
  int _intakeGoal = 2000;
  int _interval = 0;

  String get userId => _userId;
  int get totalIntake => _totalIntake;
  String get username => _username;
  String get gender => _gender;
  String get age => _age;
  String get height => _height;
  String get weight => _weight;
  int get intakeGoal => _intakeGoal;
  int get interval => _interval;
  int get calcul => (totalIntake / intakeGoal * 100).floor();
  Map<DateTime, List<String>> get intakeHistory => _intakeHistory;

  bool get isNotification => _isNotification;

  void setNotification(bool value) {
    _isNotification = value;
    notifyListeners();
  }

  void updateIntake(int intake) {
    _totalIntake += intake;
    addIntakeHistory(intake);

    notifyListeners(); // 업데이트
  }

  Future<void> resetIntake() async {
    _totalIntake = 0;

// 데이터베이스에서도 섭취 기록 초기화
    await _databaseHelper.resetWaterIntake(_userId);
    _intakeHistory.clear();

    notifyListeners();
  }

  void setUsername(String newUsername) {
    _username = newUsername;

    notifyListeners();
  }

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  Future<void> loadUserData(String userId) async {
    final userSettings = await _databaseHelper.getUserSettings(userId);
    if (userSettings != null) {
      _username = userSettings['username'] ?? "";
      _gender = userSettings['gender'] ?? "";
      _age = userSettings['age'].toString() ?? "";
      _height = userSettings['height'].toString() ?? "";
      _weight = userSettings['weight'].toString() ?? "";
      _intakeGoal = userSettings['intakeGoal'] ?? 2000;
      _interval = userSettings['interval'] ?? 0;

      notifyListeners();
    }
  }

  void setString(String gender, String age, String height, String weight) {
    _gender = gender;
    _age = age;
    _height = height;
    _weight = weight;

    notifyListeners();
  }

  void updateUserInfo(String userId, int age, String gender, double weight,
      double height) async {
    _gender = gender;
    _age = age.toString();
    _height = height.toString();
    _weight = weight.toString();

    notifyListeners();
  }

  void updateGoal(int intake, int time) {
    _intakeGoal = intake;
    _interval = time;

    notifyListeners();
  }

  void addIntakeHistory(int intakeAmount) {
    DateTime today = DateTime.now();
    if (_intakeHistory.containsKey(today)) {
      _intakeHistory[today]!.add('$intakeAmount ml');
    } else {
      _intakeHistory[today] = ['$intakeAmount ml'];
    }
    notifyListeners();
  }
}
