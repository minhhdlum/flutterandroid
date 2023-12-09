import 'package:connection/models/profile.dart';
import 'package:connection/providers/diachimodel.dart';
import 'package:connection/providers/profileviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';
import 'custom_ctrl.dart';

class SPageYourprofile extends StatelessWidget {
  const SPageYourprofile({super.key});
  static int idpage = 1;

  Future<void> init (DiachiModel dcmodel,ProfileViewModel viewmodel)async{
    Profile profile=Profile();
    if(dcmodel.listCity.isEmpty||dcmodel.curCityId!=profile.user.provinceid||dcmodel.curDistId!=profile.user.districtid||dcmodel.curWardId!=profile.user.wardid){
    viewmodel.displaySpinner();
      await dcmodel.initialize(profile.user.provinceid,profile.user.districtid, profile.user.wardid);
    viewmodel.hideSpinner();
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    final viewmodel = Provider.of<ProfileViewModel>(context);
    final dcmodel=Provider.of<DiachiModel>(context);
    Future.delayed(Duration.zero,()=>init(dcmodel, viewmodel));
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Column(
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
                              width: size.width *0.45,
                              callback: (output) {
                                profile.user.phone = output;
                                viewmodel.updatescreen();
                              },
                              type: TextInputType.phone,
                            ),
                            CustomInputTextFormField(
                              title: 'Ngày sinh',
                              value: profile.user.birthday,
                              width: size.width * 0.45,
                              callback: (output) {
                                if (AppConstant.isDate(output)) {
                                  profile.user.birthday = output;
                                }
                                viewmodel.updatescreen();
                              },
                              type: TextInputType.datetime,
                            ),
                            
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomPlaceDropDown(
                                    width: size.width * 0.45,
                                    title: 'Thành phố/Tỉnh',
                                    valueId: profile.user.provinceid,
                                    callback: (outputId,outputName)async{
                                      viewmodel.displaySpinner();
                                      profile.user.provinceid=outputId;
                                      profile.user.provincename=outputName;
                                       await dcmodel.setCity(outputId);
                                       profile.user.districtid=0;
                                        profile.user.wardid=0;
                                        profile.user.districtname="";
                                          profile.user.wardname="";
                                       print('--finished --init--');
                                       viewmodel.hideSpinner();
                                    },
                                    list: dcmodel.listCity,
                                    valuename: profile.user.provincename),
                                    CustomPlaceDropDown(
                                    width: size.width * 0.45,
                                    title: 'Quận/huyện',
                                    valueId: profile.user.districtid,
                                    callback: (outputId,outputName)async{
                                      viewmodel.displaySpinner();
                                      profile.user.districtid=outputId;
                                      profile.user.districtname=outputName;
                                       await dcmodel.setDistrict(outputId);
                                       viewmodel.hideSpinner();
                                    },
                                    list: dcmodel.listDistrict,
                                    valuename: profile.user.districtname),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),
            ],
          )),
    );
  }
}
