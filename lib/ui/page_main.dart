import 'package:avatar_glow/avatar_glow.dart';
import 'package:connection/models/profile.dart';
import 'package:connection/providers/mainviewmodel.dart';
import 'package:connection/providers/menubarviewmodel.dart';
import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/custom_ctrl.dart';
import 'package:connection/ui/page_login.dart';
import 'package:connection/ui/SubPage_Diemdanh.dart';
import 'package:connection/ui/SubPage_dslop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'page_dklop.dart';
import 'page_register.dart';
import 'SubPage_dshp.dart';
import 'SubPage_Logout.dart';
import 'SubPage_Profile.dart';
import 'SubPage_Home.dart';
import 'SubPage_dslop.dart';

class PageMain extends StatelessWidget {
  PageMain({super.key});
  static String routename = '/main';
  final List<String> menutitle = [
    "Trang chủ",
    "Trang cá nhân",
    "Điểm danh",
    "DS Lớp",
    "DS Học Phần",
    "Đăng xuất",
  ];
  final menuBar = menuitemlist();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewmodel = Provider.of<MainViewModel>(context);
    Profile profile = Profile();

    if (profile.token == "") {
      return PageLogin();
    }
    if (profile.student.mssv == "") {
      return PageDangkylop();
    }
    Widget body = SPageTrangchu();
    if (viewmodel.activemenu == SPageYourprofile.idpage) {
      body = SPageYourprofile();
    } else if (viewmodel.activemenu == SubPageDiemdanh.idpage) {
      body = SubPageDiemdanh();
    } else if (viewmodel.activemenu == SPageDSLop.idpage) {
      body = SPageDSLop();
    } else if (viewmodel.activemenu == SubPageDSHP.idpage) {
      body = SubPageDSHP();
    } else if (viewmodel.activemenu == SPageDangxuat.idpage) {
      GestureDetector(
          onTap: () =>
              Navigator.of(context).popAndPushNamed(PageLogin.routename));
    } else {
      menuBar.initialize(menutitle);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.mainColor,
        leading: GestureDetector(
          onTap: () => viewmodel.toggleMenu(),
          child: const Icon(
            size: 40,
            Icons.menu,
            color: Color.fromARGB(255, 255, 252, 252),
          ),
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Consumer<MenuBarViewModel>(builder: (context, menubarmodel, child) {
            return Container(
              child: Center(
                child: body,
              ),
            );
          }),
          viewmodel.menustatus == 1
              ? Consumer<MenuBarViewModel>(
                  builder: (context, menubarmodel, child) {
                  return GestureDetector(
                      onPanUpdate: (details) {
                        menubarmodel.setOffset(details.localPosition);
                      },
                      onPanEnd: (details) {
                        menubarmodel.setOffset(Offset(0, 0));
                        viewmodel.closeMenu();
                      },
                      child: Stack(
                        children: [
                          CustomMenuSideBar(size: size),
                          menuBar,
                        ],
                      ));
                })
              : Container(),
        ],
      )),
    );
  }
}

class menuitemlist extends StatelessWidget {
  menuitemlist({
    super.key,
  });
  final List<menubaritem> menubaritems = [];
  var status = 0;
  void initialize(List<String> menutitle) {
    if (status == 0) {
      for (int i = 0; i < menutitle.length; i++) {
        menubaritems.add(menubaritem(
            idpage: i, title: menutitle[i], containerkey: GlobalKey()));
      }
      status = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.width * 0.2,
          width: size.width * 0.6,
          child: Center(
            child: AvatarGlow(
              duration: Duration(milliseconds: 1500),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              endRadius: size.height * 0.3,
              glowColor: AppConstant.mainColor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.height),
                child: SizedBox(
                  height: size.width * 0.16,
                  width: size.width * 0.16,
                  child: CustomAvatar1(size: size),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 2,
          width: size.width * 0.6,
          color: Colors.black,
        ),
        SizedBox(
          height: size.height * 0.6,
          width: size.width * 0.6,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: menubaritems.length,
              itemBuilder: (context, index) {
                return menubaritems[index];
              },
            ),
          ),
        ),
      ],
    );
  }
}

class menubaritem extends StatelessWidget {
  menubaritem({
    super.key,
    required this.title,
    required this.containerkey,
    required this.idpage,
  });
  final int idpage;
  final String title;
  final GlobalKey containerkey;
  TextStyle style = AppConstant.textbody;
  void onPanmove(Offset offset) {
    if (offset.dy == 0) {
      style = AppConstant.textbody;
    }
    if (containerkey.currentContext != null) {
      RenderBox box =
          containerkey.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      if (offset.dy < position.dy - 40 && offset.dy > position.dy - 80) {
        style = AppConstant.textbodyfocus;
        MainViewModel().activemenu = idpage;
      } else {
        style = AppConstant.textbody;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final menubarmodel = Provider.of<MenuBarViewModel>(context);
    onPanmove(menubarmodel.offset);
    return GestureDetector(
      onTap: () => MainViewModel().setActiveMenu(idpage),
      child: Container(
        key: containerkey,
        alignment: Alignment.centerLeft,
        height: 40,
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }
}

class CustomMenuSideBar extends StatelessWidget {
  const CustomMenuSideBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final sizebarmodel = Provider.of<MenuBarViewModel>(context);
    final size = MediaQuery.of(context).size;
    return CustomPaint(
      size: Size(size.width * 0.6, size.height * 1),
      painter: DrawerCustomPaint(offset: sizebarmodel.offset),
    );
  }
}

class DrawerCustomPaint extends CustomPainter {
  final Offset offset;

  DrawerCustomPaint({super.repaint, required this.offset});
  double generatePointX(double width) {
    double kq = 0;
    if (offset.dx == 0) {
      kq = width;
    } else if (offset.dx < width) {
      kq = width + 75;
    } else {
      kq = offset.dx;
    }
    return kq;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
        generatePointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
