import 'package:connection/ui/page_main.dart';
import 'package:flutter/material.dart';
import 'AppConstant.dart';

class SPageDangxuat extends StatelessWidget {
  const SPageDangxuat({super.key});
  static int idpage = 5;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).popAndPushNamed(PageMain.routename),
      child: Container(
          color: AppConstant.backgroundColor,
          child: const Center(
            child: Text("Đăng xuất"),
          )),
    );
  }
}
