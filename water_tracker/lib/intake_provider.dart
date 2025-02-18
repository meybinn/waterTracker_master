import 'package:flutter/material.dart';

class IntakeProvider with ChangeNotifier {
  int _totalIntake = 0;

  String _username = "";

  String _gender = "";
  String _age = "";
  String _height = "";
  String _weight = "";

  int _intakeGoal = 2000;
  int _interval = 0;

  int get totalIntake => _totalIntake;
  String get username => _username;
  String get gender => _gender;
  String get age => _age;
  String get height => _height;
  String get weight => _weight;
  int get intakeGoal => _intakeGoal;
  int get interval => _interval;
  int get calcul => (totalIntake / intakeGoal * 100).floor();

  void updateIntake(int intake) {
    _totalIntake += intake;

    notifyListeners(); // 업데이트
  }

  void resetIntake() {
    _totalIntake = 0;

    notifyListeners();
  }

  void setUsername(String username) {
    _username = username;

    notifyListeners();
  }

  void setString(String gender, String age, String height, String weight) {
    _gender = gender;
    _age = age;
    _height = height;
    _weight = weight;

    notifyListeners();
  }

  void updateGoal(int intake, int time) {
    _intakeGoal = intake;
    _interval = time;

    notifyListeners();
  }

  // void calculation() {
  //   _calcul = ;

  //   notifyListeners();
  // }
}
