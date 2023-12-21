import 'dart:io';

import 'package:connection/models/user.dart';
import 'package:connection/services/api_services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserRepository {
  Future<User> getUserInfo() async {
    User user = User();
    final response = await ApiService().getUserInfo();
    if (response != null) {
      var json = response.data['data'];
      user = User.fromJson(json);
      DateTime date = DateTime.parse(user.birthday);
      String birthdayformat = DateFormat('dd-MM-yyyy').format(date);
      user.birthday = birthdayformat;
      String birthday = "";
      if (user.birthday.isNotEmpty) {
        String temp = user.birthday;
        int ti = temp.indexOf('-', 0);
        String subday = temp.substring(0, ti);
        int tm = temp.indexOf('-', ti + 1);
        String submonth = temp.substring(ti + 1, tm);
        String subyear = temp.substring(tm + 1, temp.length);
        birthday = '$subday/$submonth/$subyear';
        user.birthday = birthday;
      }
    }
    return user;
  }

  Future<bool> updateProfile() async {
    bool kq = false;
    var response = await ApiService().updateProfile();
    if (response != null) {
      kq = true;
    }
    return kq;
  }

  Future<void> uploadAvatar(XFile image) async {
    ApiService api = ApiService();
    final img.Image origianlImage =
        img.decodeImage(File(image.path).readAsBytesSync())!;
    final img.Image resizedImage = img.copyResize(origianlImage, width: 250);
    final File resizedFile =
        File(image.path.replaceAll('.jpg', '_resized.jpg'))
          ..writeAsBytesSync(img.encodeJpg(resizedImage));
    await api.uploadAvatarToServer(File(resizedFile.path));
    }
}
