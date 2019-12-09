import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/data/raport_model.dart';
import 'package:mrc/screens/supervisor/browse_screen.dart';

class SupervisorPanel extends StatefulWidget {
  SupervisorPanel({
    Key key,
  }) : super(key: key);

  @override
  _SupervisorPanelState createState() => _SupervisorPanelState();
}

class _SupervisorPanelState extends State<SupervisorPanel> {
  final _barHeight = 100.0;
  int _screenIndex = 0;
  List<RaportModel> _readyRaports = initialRaports();

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
                color: whiteColor,
                width: screenWidth,
                height: _barHeight,
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
                height: _barHeight,
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 10),
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
          icon: Icon(Icons.center_focus_weak),
          onPressed: () {
            _changeScreen(1);
          },
          color: _screenIndex == 1 ? accentColor : primaryGreenColor,
        ),
        IconButton(
          iconSize: 35,
          icon: Icon(Icons.person),
          onPressed: () {
            _changeScreen(2);
          },
          color: _screenIndex == 2 ? accentColor : primaryGreenColor,
        ),
        IconButton(
          iconSize: 35,
          icon: Icon(Icons.insert_chart),
          onPressed: () {
            _changeScreen(3);
          },
          color: _screenIndex == 3 ? accentColor : primaryGreenColor,
        ),
      ],
    );
  }

  String _getScreenName() {
    switch (_screenIndex) {
      case 0:
        return "Browse reports";
      case 1:
        return "Manage reports";
      case 2:
        return "Patient info";
      case 3:
        return "Statistics";
      default:
        return "";
    }
  }

  Widget _getScreenWidget() {
    switch (_screenIndex) {
      case 0:
        return BrowseScreen(_readyRaports);
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return Container();
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
}