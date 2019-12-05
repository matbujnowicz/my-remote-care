import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/widgets/card_default.dart';
import 'package:mrc/widgets/primary_button.dart';
import 'package:mrc/widgets/text_button.dart';
import 'package:mrc/widgets/text_field_default.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({
    Key key,
  }) : super(key: key);

  @override
  _RegisterScreenScreenState createState() => _RegisterScreenScreenState();
}

class _RegisterScreenScreenState extends State<RegisterScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _retypePasswordController;
  bool _isCaregiver = false;

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
                _buildRegisterCard(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: PrimaryButton(
                      text: "Register",
                      onPressed: _handleRegister,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: TextButton(
                      text: "Log in to existing account",
                      onPressed: _handleGoToLogin,
                      textStyle: accentFont,
                      pressedTextStyle: grayFont,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRegisterCard() {
    return CardDefault(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 15),
              child: Text("Register", style: greenBoldFont)),
          Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Supervisor",
                      style: _isCaregiver ? greenFont : greenBoldFont),
                  Switch(
                    value: _isCaregiver,
                    onChanged: _switchRole,
                  ),
                  Text("Caregiver",
                      style: _isCaregiver ? greenBoldFont : greenFont),
                ],
              )),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: TextFieldDefault(
              controller: _emailController,
              hint: "Email address",
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: TextFieldDefault(
              controller: _passwordController,
              hint: "Password",
              obscureText: true,
            ),
          ),
          TextFieldDefault(
            controller: _retypePasswordController,
            hint: "Retype password",
            obscureText: true,
          )
        ],
      ),
    );
  }

  void _handleRegister() {
    if (_passwordController.text != _retypePasswordController.text)
      print("Passwords are not the same");
  }

  void _handleGoToLogin() {
    Navigator.pushNamed(context, "/");
  }

  void _switchRole(bool value) {
    setState(() {
      _isCaregiver = value;
    });
  }
}
