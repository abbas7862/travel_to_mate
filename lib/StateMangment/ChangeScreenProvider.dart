import 'package:flutter/material.dart';

class ChnageScreenProvider with ChangeNotifier {
  int _selectIndex = 0;

  int get getSelectedIndex => _selectIndex;

  void updateIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }

  void resetIndex() {
    _selectIndex = 0;
    notifyListeners();
  }
}
