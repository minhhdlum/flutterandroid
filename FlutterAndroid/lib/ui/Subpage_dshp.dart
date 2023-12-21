import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

class SubPageDSHP extends StatelessWidget {
  const SubPageDSHP({super.key});
  static int idpage = 4;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
          color: AppConstant.backgroundColor,
          child: const Center(
            child: Text("DS Học Phần",style: TextStyle(fontSize: 25),),
          )),
    );
  }
}
