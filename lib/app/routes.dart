import 'package:flutter/widgets.dart';
import 'package:mrc/screens/authentication/login_screen.dart';
import 'package:mrc/screens/authentication/register_screen.dart';
import 'package:mrc/screens/supervisor/supervisor_panel.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/supervisorPanel': (context) => SupervisorPanel(),
};
