import 'package:connection/models/profile.dart';
import 'package:connection/providers/loginviewmodel.dart';
import 'package:connection/repositories/place_repositories.dart';
import 'package:flutter/material.dart';

class MainViewModel with ChangeNotifier {
  static final MainViewModel _instance = MainViewModel._internal();
  MainViewModel._internal();
  factory MainViewModel() {
    return _instance;
  }
  int menustatus = 0; //0 close 1 open
  int activemenu = 0; // index cua menu item
  void toggleMenu() {
    if (menustatus == 0) {
      menustatus = 1;
    } else {
      menustatus = 0;
    }
    notifyListeners();
  }

  void closeMenu() {
    menustatus = 0;
    notifyListeners();
  }

  void setActiveMenu(int index) {
    activemenu = index;
    menustatus = 0;
    notifyListeners();
  }
}
