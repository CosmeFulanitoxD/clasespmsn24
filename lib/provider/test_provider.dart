import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  String _Name = 'max';
  String get name => _Name;
  set name(String value) {
    _Name = value;
    notifyListeners();
  }
}
