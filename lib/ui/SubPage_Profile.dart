import 'package:connection/models/profile.dart';
import 'package:connection/providers/profileviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';
import 'custom_ctrl.dart';

class SPageYourprofile extends StatelessWidget {
  const SPageYourprofile({super.key});
  static int idpage = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    final viewmodel=Provider.of<ProfileViewModel>(context);
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: size.height * 0.20,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppConstant.mainColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60))),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text(
                                profile.student.diem.toString(),
                                style: AppConstant.textbodyw,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomAvatar1(size: size),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.user.first_name,
                            style: AppConstant.textbodyfocusw,
                          ),
                          Row(
                            children: [
                              Text(
                                'MSSV: ',
                                style: AppConstant.textbodyw,
                              ),
                              Text(
                                profile.student.mssv,
                                style: AppConstant.textbodyw,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Lớp: ',
                                style: AppConstant.textbodyw,
                              ),
                              Text(
                                profile.student.tenlop,
                                style: AppConstant.textbodyw,
                              ),
                              profile.student.duyet == 0
                                  ? Text(
                                      " (chưa duyệt)",
                                      style: AppConstant.textbodyw,
                                    )
                                  : Text(''),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Vai trò: ',
                                style: AppConstant.textbodyw,
                              ),
                              profile.user.role_id == 4
                                  ? Text(
                                      'sinh viên',
                                      style: AppConstant.textbodyw,
                                    )
                                  : Text(
                                      'giảng viên',
                                      style: AppConstant.textbodyw,
                                    )
                            ],
                          )
                        ],
                      )
                    ]),
              ), //end header....*****
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomInputTextFormField(
                          title: 'Điện thoại',
                          value: profile.user.phone,
                          width: size.width / 2,
                          callback: (output) {
                            profile.user.phone = output;
                            viewmodel.updatescreen();
                          },
                          type: TextInputType.phone, 
                        ),
                        CustomInputTextFormField(
                      title: 'Ngày sinh',
                      value: profile.user.birthday,
                      width: size.width *0.35,
                      callback: (output) {
                        if(AppConstant.isDate(output)){
                        profile.user.birthday = output;
                        }
                        viewmodel.updatescreen();
                      },
                      type: TextInputType.datetime,
                    )
                      ],
                    ),
                  ],
                ),
              ),
              
            ],
          )),
    );
  }
}
