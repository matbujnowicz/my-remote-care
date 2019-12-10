import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';

class SingleScreenArguments {
  final String title;
  final Widget child;

  SingleScreenArguments({@required this.child, this.title = ""});
}

class SingleScreen extends StatelessWidget {
  final _barHeight = 100.0;
  final SingleScreenArguments arguments;

  SingleScreen(this.arguments);

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
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios),
                      color: accentColor,
                      iconSize: 35,
                    ),
                    left: 10,
                    bottom: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      arguments.title,
                      style: greenBoldFont.copyWith(fontSize: 30),
                    ),
                  ),
                ]),
              ),
              Expanded(child: arguments.child)
            ],
          )
        ],
      ),
    );
  }
}
