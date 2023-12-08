import 'package:connection/models/profile.dart';
import 'package:connection/models/student.dart';
import 'package:connection/repositories/lop_repository.dart';
import 'package:connection/repositories/student_repository.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_ctrl.dart';
import 'package:connection/ui/page_main.dart';
import 'package:flutter/material.dart';

import '../models/class.dart';
import '../repositories/user_repository.dart';

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
              SizedBox(
                height: 20,
              ),
              Text(
                  'Bạn không thể quay trở lại trang sau khi rời đi. Vì vậy hãy kiểm tra kỹ nhé!',
                  style: AppConstant.text_error),
              SizedBox(
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
              SizedBox(height: 10),
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
                          return Text('Loi xay ra');
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
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: ()async{
                          profile.student.mssv=mssv;
                          profile.student.idlop=idlop;
                          profile.student.tenlop=tenlop;
                          profile.user.first_name=ten;
                          //await UserRepository().updateProfile();
                          await StudentRepository().dangkyLop();
                        },
                        child: Custom_Button(textButton: 'Lưu thông tin')),
                      SizedBox(height: 20,),
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

class CustomInputTextFormField extends StatefulWidget {
  const CustomInputTextFormField({
    super.key,
    required this.width,
    required this.title,
    required this.value,
    required this.callback,
    this.type = TextInputType.text,
  });

  final double width;
  final String title;
  final String value;
  final TextInputType type;
  final Function(String output) callback;

  @override
  State<CustomInputTextFormField> createState() =>
      _CustomInputTextFormFieldState();
}

class _CustomInputTextFormFieldState extends State<CustomInputTextFormField> {
  int status = 0;
  String output = "";

  @override
  void initState() {
    output=widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppConstant.textbody,
          ),
          status == 0
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      status = 1;
                    });
                  },
                  child: Text(
                    widget.value == "" ? "Không có" : widget.value,
                    style: AppConstant.textbodyfocus,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200]),
                      width: widget.width - 50,
                      child: TextFormField(
                        keyboardType: widget.type,
                        onChanged: (value) {
                          setState(() {
                            output = value;
                            widget.callback(output);
                          });
                        },
                        decoration: InputDecoration(border: InputBorder.none),
                        initialValue: output,
                        style: AppConstant.textbodyfocus,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          status = 0;
                          widget.callback(output);
                        });
                      },
                      child: Icon(
                        Icons.save,
                        size: 30,
                      ),
                    )
                  ],
                ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

class CustomInputDropDown extends StatefulWidget {
  const CustomInputDropDown({
    super.key,
    required this.width,
    required this.title,
    required this.valueId,
    required this.callback,
    required this.list,
    required this.valuename,
  });

  final double width;
  final String title;
  final int valueId;
  final String valuename;
  final List<Lop> list;
  final Function(int outputId, String outputName) callback;
  @override
  State<CustomInputDropDown> createState() => _CustomInputDropDownState();
}

class _CustomInputDropDownState extends State<CustomInputDropDown> {
  int status = 0;
  int outputId = 0;
  String outputName = "";

  @override
  void initState() {
    // TODO: implement initState
    outputId = widget.valueId;
    outputName = widget.valuename;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppConstant.textbody,
        ),
        status == 0
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    status = 1;
                  });
                },
                child: Text(outputName == "" ? "Không có" : outputName,
                    style: AppConstant.textbodyfocus),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200]),
                width: widget.width - 25,
                child: DropdownButton(
                  value: outputId,
                  items: widget.list
                      .map((e) => DropdownMenuItem(
                          value: e.id,
                          child: Container(
                              width: widget.width * 0.8,
                              decoration:
                                  BoxDecoration(color: Colors.grey[200]),
                              child: Text(
                                e.ten,
                                overflow: TextOverflow.ellipsis,
                              ))))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      outputId = value!;
                      for (var dropitem in widget.list) {
                        if (dropitem.id == outputId) {
                          outputName = dropitem.ten;
                          widget.callback(outputId, outputName);
                          break;
                        }
                      }
                      status = 0;
                    });
                  },
                )),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
