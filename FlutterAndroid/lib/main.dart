import 'package:connection/providers/profileviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/diachimodel.dart';
import 'ui/page_forgot.dart';
import 'ui/page_login.dart';
import 'ui/page_main.dart';
import 'ui/page_register.dart';
import 'models/profile.dart';
import 'providers/forgotviewmodel.dart';
import 'providers/loginviewmodel.dart';
import 'providers/mainviewmodel.dart';
import 'providers/menubarviewmodel.dart';
import 'providers/registerviewmodel.dart';
import 'services/api_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ApiService api = ApiService();
  api.initialize();
  Profile profile = Profile();
  profile.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(),
    ),
    ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => RegisterViewModel(),
    ),
    ChangeNotifierProvider<ForgotViewmodel>(
      create: (context) => ForgotViewmodel(),
    ),
    ChangeNotifierProvider<MainViewModel>(
      create: (context) => MainViewModel(),
    ),
    ChangeNotifierProvider<MenuBarViewModel>(
      create: (context) => MenuBarViewModel(),
    ),
    ChangeNotifierProvider<ProfileViewModel>(
      create: (context) => ProfileViewModel(),
    ),
    ChangeNotifierProvider<DiachiModel>(
      create: (context) => DiachiModel(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/main': (context) => PageMain(),
        '/login': (context) => PageLogin(),
        '/register': (context) => PageRegister(),
        '/forgot': (context) => PageForgot(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
        colorScheme:
            const ColorScheme.light(primary: Color.fromRGBO(233, 112, 120, 1)),
        useMaterial3: true,
      ),
      home: PageLogin(),
    );
  }
}
