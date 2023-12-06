import 'package:connection/ui/AppConstant.dart';
import 'package:connection/ui/page_forgot.dart';
import 'package:connection/ui/page_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/loginviewmodel.dart';
import 'custom_ctrl.dart';
import 'page_main.dart';

class PageLogin extends StatelessWidget {
  PageLogin({super.key});
  static String routename = '/login';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<LoginViewModel>(context);
    final size = MediaQuery.of(context).size;
    if (viewmodel.status == 3) {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.popAndPushNamed(context, PageMain.routename);
        },
      );
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 187, 209),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100.0),
                        child: AppLogo(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: const Text(
                        "Chúng tớ nhớ cậu lắm !",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 247, 67, 106)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Text(
                      "Điền thông tin vào đây nhé ♥!",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 247, 67, 106)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: "Tên người dùng ♥", //xntruong || ads
                      textController: _emailController,
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: "Mật khẩu ༼ つ ◕_◕ ༽つ", //123456789 || 12345678
                      textController: _passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    viewmodel.status == 2
                        ? Text(viewmodel.errorMessage,
                            style: const TextStyle(color: Colors.red))
                        : const Text(""),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        String username = _emailController.text.trim();
                        String password = _passwordController.text.trim();
                        viewmodel.login(username, password);
                      },
                      child: const Custom_Button(
                        textButton: "Đăng nhập",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Chưa có tài khoản?",
                          style: TextStyle(fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .popAndPushNamed(PageRegister.routename),
                          child: Text("Đăng ký",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 240, 61, 61))),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .popAndPushNamed(PageForgot.routename),
                      child: Text(
                        "Quên mật khẩu!",
                        style: AppConstant.textlink,
                      ),
                    )
                  ],
                ),
              ),
              viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),
            ],
          ),
        ),
      )),
    );
  }
}
