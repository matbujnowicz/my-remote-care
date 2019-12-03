import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/widgets/card_default.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  _LoginScreenScreenState createState() => _LoginScreenScreenState();
}

class _LoginScreenScreenState extends State<LoginScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

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
          Container(
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CardDefault(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "My Remote Care",
                      style: greenBoldFont.copyWith(fontSize: 30),
                    ),
                  ),
                  margin: const EdgeInsets.only(top: 85),
                ),
                CardDefault(
                  margin: const EdgeInsets.only(top: 20),
                  child: _buildLoginCard(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLoginCard() {
    return Column(
      children: <Widget>[
        Text("Login", style: greenBoldFont),
        TextField(
          //TODO -> EXPORT THIS TEXTFIELD TO WIDGET
          autocorrect: false,
          controller: _emailController,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(15)),
              borderSide: BorderSide(
                color: primaryGreenColor,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(15)),
              borderSide: BorderSide(color: grayColor, width: 1.0),
            ),
            hintText: 'Email address',
          ),
        ),
        TextField(
          controller: _passwordController,
        )
      ],
    );
  }
}
