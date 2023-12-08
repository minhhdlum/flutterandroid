import 'package:flutter/material.dart';

class ProfileViewModel with ChangeNotifier{
  int status=0;
  void updatescreen(){
    notifyListeners();
  }
}