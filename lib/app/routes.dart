import 'package:flutter/widgets.dart';
import 'package:mrc/screens/authentication/login_screen.dart';
import 'package:mrc/screens/authentication/register_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
};
