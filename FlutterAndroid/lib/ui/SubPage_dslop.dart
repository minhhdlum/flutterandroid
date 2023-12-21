import 'package:flutter/material.dart';
import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

class SPageDSLop extends StatelessWidget {
  const SPageDSLop({super.key});
  static int idpage = 3;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
          color: AppConstant.backgroundColor,
          child: const Center(
            child: Text("DS Lớp"),
          )),
    );
  }
}
