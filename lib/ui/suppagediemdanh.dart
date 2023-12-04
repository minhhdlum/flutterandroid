import 'package:flutter/material.dart';
import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

class SubPageDiemdanh extends StatelessWidget {
  const SubPageDiemdanh({super.key});
  static int idpage = 4;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
          color: AppConstant.backgroundColor,
          child: Center(
            child: Text("Điểm danh"),
          )),
    );
  }
}
