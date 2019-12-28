import 'package:flutter/widgets.dart';
import 'package:mrc/screens/authentication/login_screen.dart';
import 'package:mrc/screens/authentication/register_screen.dart';
import 'package:mrc/screens/caregiver/caregiver_panel.dart';
import 'package:mrc/screens/common/report_screen.dart';
import 'package:mrc/screens/supervisor/add_report_screen.dart';
import 'package:mrc/screens/supervisor/supervisor_panel.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/supervisorPanel': (context) =>
      SupervisorPanel(user: ModalRoute.of(context).settings.arguments),
  '/caregiverPanel': (context) =>
      CaregiverPanel(user: ModalRoute.of(context).settings.arguments),
  '/reportScreen': (context) =>
      ReportScreen(arguments: ModalRoute.of(context).settings.arguments),
  '/addReportScreen': (context) =>
      AddReportScreen(arguments: ModalRoute.of(context).settings.arguments),
};
