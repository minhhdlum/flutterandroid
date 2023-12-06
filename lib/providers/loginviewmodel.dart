import 'package:connection/repositories/login_repositories.dart';
import 'package:connection/repositories/student_repository.dart';
import 'package:connection/repositories/user_repository.dart';
import 'package:flutter/material.dart';

import '../models/student.dart';
import '../models/user.dart';

class LoginViewModel with ChangeNotifier {
  String errorMessage = "";
  int status = 0;
  LoginRepository loginRepo = LoginRepository();
  Future<void> login(String username, String password) async {
    status = 1;
    notifyListeners();
    try {
      var profile = await loginRepo.login(username, password);
      if (profile.token == "") {
        status = 2;
        errorMessage = "Tên đăng nhập hoặc mật khẩu không đúng!";
      } else {
        
        //dang nhap thanh cong, lay thong tin user student
        var student =await StudentRepository().getStudentInfo();
        profile.student=Student.fromStudent(student);
        var user =await UserRepository().getUserInfo();
        profile.user=User.fromUser(user);
        status = 3;
      }
      notifyListeners();
    } catch (e) {}
  }
}
