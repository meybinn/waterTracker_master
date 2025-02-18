import 'package:flutter/material.dart';

class IntakeProvider with ChangeNotifier {
  int _totalIntake = 0;

  int get totalIntake => _totalIntake;

  void updateIntake(int intake) {
    _totalIntake = intake;

    notifyListeners(); // 업데이트
  }
}

void main() {
  IntakeProvider intakeProvider = IntakeProvider();

  int totalIntake = intakeProvider.totalIntake;
}
