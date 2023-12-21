import 'package:connection/models/profile.dart';
import 'package:connection/models/user.dart';
import 'package:connection/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel with ChangeNotifier {
  int status = 0; //display status
  int modified = 0;
  int updateavatar = 0;
  int upload = 0;
  int ds = 0;
  int dshuyen = 0;
  int dsxa = 0;
  void updateAvatar() {
    updateavatar = 1;
    upload = 1;
    notifyListeners();
  }

  void updatescreen() {
    notifyListeners();
  }

  void displaySpinner() {
    status = 1;
    notifyListeners();
  }

  void hideSpinner() {
    status = 0;
    notifyListeners();
  }

  void setModified() {
    if (modified == 0) {
      modified = 1;
      int ds = 0;
      int dshuyen = 0;
      int dsxa = 0;
      notifyListeners();
    }
  }

  Future<void> updateProfile() async {
    status = 1;
    notifyListeners();
    await UserRepository().updateProfile();
    status = 0;
    modified = 0;
    notifyListeners();
  }

  Future<void> uploadAvatar(XFile image) async {
    status = 1;
    notifyListeners();
    await UserRepository().uploadAvatar(image);
    print('Upload Success');
    var user = await UserRepository().getUserInfo();
    Profile().user = User.fromUser(user);
    updateavatar = 0;
    status = 0;
    upload = 0;
    notifyListeners();
  }
}
