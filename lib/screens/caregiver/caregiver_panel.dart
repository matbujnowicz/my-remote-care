import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/data/patient_model.dart';
import 'package:mrc/data/report_model.dart';
import 'package:mrc/data/sample_reports.dart';
import 'package:mrc/screens/caregiver/dashboard_screen.dart';
import 'package:mrc/screens/caregiver/patient_info_screen.dart';
import 'package:mrc/screens/caregiver/supervisor_screen.dart';

class CaregiverPanel extends StatefulWidget {
  CaregiverPanel({
    Key key,
  }) : super(key: key);

  @override
  _CaregiverPanelState createState() => _CaregiverPanelState();
}

class _CaregiverPanelState extends State<CaregiverPanel> {
  int _screenIndex = 0;
  List<ReportModel> _readyReports = readyReports();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final PatientModel patient = PatientModel(
      name: "Walery",
      surname: "Sudack",
      height: "190",
      weight: "55",
      yearOfBirth: "1920");

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(gradient: backgroundGradient),
          ),
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 50),
                color: whiteColor,
                width: screenWidth,
                child: Stack(children: <Widget>[
                  Positioned(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/");
                      },
                      icon: Icon(Icons.power_settings_new),
                      color: accentColor,
                      iconSize: 35,
                    ),
                    right: 10,
                    bottom: 0,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      _getScreenName(),
                      style: greenBoldFont.copyWith(fontSize: 30),
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: _getScreenWidget(),
                ),
              ),
              Container(
                color: whiteColor,
                width: screenWidth,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: _buildNavigationBar(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          iconSize: 35,
          icon: Icon(Icons.center_focus_strong),
          onPressed: () {
            _changeScreen(0);
          },
          color: _screenIndex == 0 ? accentColor : primaryGreenColor,
        ),
        IconButton(
          iconSize: 35,
          icon: Icon(Icons.person),
          onPressed: () {
            _changeScreen(1);
          },
          color: _screenIndex == 1 ? accentColor : primaryGreenColor,
        ),
        IconButton(
          iconSize: 35,
          icon: Icon(Icons.loupe),
          onPressed: () {
            _changeScreen(2);
          },
          color: _screenIndex == 2 ? accentColor : primaryGreenColor,
        ),
      ],
    );
  }

  String _getScreenName() {
    switch (_screenIndex) {
      case 0:
        return "Dashboard";
      case 1:
        return "Patient info";
      case 2:
        return "Supervisor";
      default:
        return "";
    }
  }

  Widget _getScreenWidget() {
    switch (_screenIndex) {
      case 0:
        return DashboardScreen(_readyReports);
      case 1:
        return PatientInfoScreen(patient);
      case 2:
        return SupervisorScreen();
      default:
        return Container();
    }
  }

  void _changeScreen(int newScreenIndex) {
    if (newScreenIndex == _screenIndex) return;
    setState(() {
      _screenIndex = newScreenIndex;
    });
  }

  Future<void> logOut() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, "/");
  }
}