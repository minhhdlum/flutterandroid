import 'dart:io';

import 'package:connection/models/profile.dart';
import 'package:connection/providers/diachimodel.dart';
import 'package:connection/providers/profileviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';
import 'custom_ctrl.dart';

class SPageYourprofile extends StatelessWidget {
  SPageYourprofile({super.key});
  static int idpage = 1;
  XFile? image;
  Future<void> init(DiachiModel dcmodel, ProfileViewModel viewmodel) async {
    Profile profile = Profile();
    if (dcmodel.listCity.isEmpty ||
        dcmodel.curCityId != profile.user.provinceid ||
        dcmodel.curDistId != profile.user.districtid ||
        dcmodel.curWardId != profile.user.wardid) {
      viewmodel.displaySpinner();
      await dcmodel.initialize(profile.user.provinceid, profile.user.districtid,
          profile.user.wardid);
      viewmodel.hideSpinner();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    final viewmodel = Provider.of<ProfileViewModel>(context);
    final dcmodel = Provider.of<DiachiModel>(context);
    Future.delayed(Duration.zero, () => init(dcmodel, viewmodel));

    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: SafeArea(
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
                                      ),
                                      viewmodel.upload == 1
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  viewmodel
                                                      .uploadAvatar(image!);
                                                },
                                                child: Container(
                                                    child: Icon(Icons.save)),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                        onTap: () async {
                                          viewmodel.updateavatar = 0;
                                          final ImagePicker _picker =
                                              ImagePicker();
                                          image = await _picker.pickImage(
                                              source: ImageSource.gallery);
                                          viewmodel.updateAvatar();
                                        },
                                        child: viewmodel.updateavatar == 1 &&
                                                image != null
                                            ? Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: SizedBox(
                                                      width: 100,
                                                      height: 100,
                                                      child: Image.file(
                                                        File(image!.path),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : CustomAvatar1(size: size)),
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
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      viewmodel.updateProfile();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: viewmodel.modified == 1
                                          ? Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color.fromARGB(
                                                      255,
                                                      252,
                                                      252,
                                                      252), // You can set the color of the border
                                                  width:
                                                      2.0, // You can set the width of the border
                                                ),
                                              ),
                                              child: Text('Lưu thông tin!',
                                                  style: AppConstant
                                                      .textbodyfocusw))
                                          : Container(),
                                    ),
                                  )
                                ],
                              )
                            ]),
                      ), //end header....*****
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomInputTextFormField(
                                    title: 'Điện thoại',
                                    value: profile.user.phone,
                                    width: (size.width / 2) - 30,
                                    callback: (output) {
                                      profile.user.phone = output;
                                      viewmodel.setModified();
                                      viewmodel.updatescreen();
                                    },
                                    type: TextInputType.phone,
                                  ),
                                  CustomInputTextFormField(
                                    title: 'Ngày sinh',
                                    value: profile.user.birthday,
                                    width: (size.width / 2) - 30,
                                    callback: (output) {
                                      if (AppConstant.isDate(output)) {
                                        profile.user.birthday = output;
                                      }
                                      viewmodel.setModified();
                                      viewmodel.updatescreen();
                                    },
                                    type: TextInputType.datetime,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomPlaceDropDown(
                                      width: (size.width / 2) - 30,
                                      title: 'Thành phố/Tỉnh',
                                      valueId: profile.user.provinceid,
                                      callback: (outputId, outputName) async {
                                        if (outputId !=
                                            profile.user.provinceid) {
                                          viewmodel.displaySpinner();
                                          profile.user.provinceid = outputId;
                                          profile.user.provincename =
                                              outputName;
                                          await dcmodel.setCity(outputId);
                                          profile.user.districtid = 0;
                                          profile.user.wardid = 0;
                                          profile.user.districtname = "";
                                          profile.user.wardname = "";
                                          viewmodel.hideSpinner();
                                          viewmodel.setModified();
                                        }
                                      },
                                      list: dcmodel.listCity,
                                      valuename: profile.user.provincename),
                                  CustomPlaceDropDown(
                                      width: (size.width / 2) - 30,
                                      title: 'Quận/huyện',
                                      valueId: profile.user.districtid,
                                      callback: (outputId, outputName) async {
                                        if (outputId !=
                                            profile.user.districtid) {
                                          viewmodel.displaySpinner();
                                          profile.user.districtid = outputId;
                                          profile.user.districtname =
                                              outputName;
                                          await dcmodel.setDistrict(outputId);
                                          profile.user.wardid = 0;
                                          profile.user.wardname = "";
                                          viewmodel.setModified();
                                          viewmodel.hideSpinner();
                                        }
                                      },
                                      list: dcmodel.listDistrict,
                                      valuename: profile.user.districtname),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomPlaceDropDown(
                                      width: (size.width / 2) - 30,
                                      title: 'Huyện/xã',
                                      valueId: profile.user.wardid,
                                      callback: (outputId, outputName) async {
                                        viewmodel.displaySpinner();
                                        profile.user.wardid = outputId;
                                        profile.user.wardname = outputName;
                                        await dcmodel.setWard(outputId);
                                        viewmodel.setModified();
                                        viewmodel.hideSpinner();
                                      },
                                      list: dcmodel.listWard,
                                      valuename: profile.user.wardname),
                                  CustomInputTextFormField(
                                    title: 'Tên đường/số nhà',
                                    value: profile.user.address,
                                    width: (size.width / 2) - 30,
                                    callback: (output) {
                                      profile.user.address = output;
                                      viewmodel.setModified();
                                      viewmodel.updatescreen();
                                    },
                                    type: TextInputType.streetAddress,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                  width: size.width * 0.3,
                                  height: size.height * 0.3,
                                  child: QrImageView(
                                    data: '{userid:' +
                                        profile.user.id.toString() +
                                        '}',
                                    version: QrVersions.auto,
                                    gapless: false,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),
            ],
          )),
    );
  }
}
