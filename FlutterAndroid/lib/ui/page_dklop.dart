import 'package:connection/models/profile.dart';
import 'package:connection/repositories/lop_repository.dart';
import 'package:connection/repositories/student_repository.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_ctrl.dart';
import 'package:connection/ui/page_main.dart';
import 'package:flutter/material.dart';

import '../models/class.dart';

class PageDangkylop extends StatefulWidget {
  const PageDangkylop({super.key});

  @override
  State<PageDangkylop> createState() => _PageDangkylopState();
}

class _PageDangkylopState extends State<PageDangkylop> {
    List<Lop>? listlop = [];
    Profile profile = Profile();
    String mssv = "";
    String ten = "";
    int idlop = 0;
    String tenlop = "";
    @override
  void initState() {
    // TODO: implement initState
    mssv = profile.student.mssv;
    ten = profile.user.first_name;
    idlop = profile.student.idlop;
    tenlop = profile.student.tenlop;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;
    //**********/
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Thêm thông tin cơ bản',
                style: AppConstant.textfancyheader2,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                  'Bạn không thể quay trở lại trang sau khi rời đi. Vì vậy hãy kiểm tra kỹ nhé!',
                  style: AppConstant.text_error),
              const SizedBox(
                height: 20,
              ),
              CustomInputTextFormField(
                title: 'Tên',
                width: size.width,
                callback: (output) {
                  ten = output;
                },
                  value: ten,
              ),
              const SizedBox(height: 10),
              CustomInputTextFormField(
                title: 'MSSV',
                width: size.width,
                callback: (output) {
                  mssv = output;
                },
                   value: mssv,
              ),
              listlop!.isEmpty
                  ? FutureBuilder(
                      future: LopRepository().getDsLop(),
                      builder: (context, AsyncSnapshot<List<Lop>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          listlop = snapshot.data;
                          return CustomInputDropDown(
                              width: size.width,
                              title: "Lớp",
                              valueId: idlop,
                              callback: (outputId, outputName) {
                                idlop = outputId;
                                tenlop:
                                outputName;
                              },
                              list: listlop!,
                              valuename: tenlop);
                        } else {
                          return const Text('Loi xay ra');
                        }
                      })
                  : CustomInputDropDown(
                      width: size.width,
                      title: "Lớp",
                      valueId: idlop,
                      callback: (outputId, outputName) {
                        idlop = outputId;
                        tenlop:
                        outputName;
                      },
                      list: listlop!,
                      valuename: tenlop),
                      const SizedBox(height: 20,),
                      GestureDetector(
                        onTap: ()async{
                          profile.student.mssv=mssv;
                          profile.student.idlop=idlop;
                          profile.student.tenlop=tenlop;
                          profile.user.first_name=ten;
                          //await UserRepository().updateProfile();
                          await StudentRepository().dangkyLop();
                        },
                        child: const Custom_Button(textButton: 'Lưu thông tin')),
                      const SizedBox(height: 20,),
                      GestureDetector(onTap: (){
                        Navigator.popAndPushNamed(context, PageMain.routename);
                      },
                        child: Text('Trang chủ',style: AppConstant.textlink,))
            ],
          ),
        ),
      )),
    );
  }
}