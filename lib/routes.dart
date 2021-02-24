import 'package:flutter/material.dart';

import 'ui/home/home.dart';
import 'ui/auth/login/login.dart';
import 'ui/auth/splash/splash.dart';
import 'package:boilerplate/ui/auth/register/register.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    register: (BuildContext context) => RegisterScreen(),
    home: (BuildContext context) => HomeScreen(),
  };
}



