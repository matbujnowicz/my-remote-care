import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/screens/caregiver/caregiver_panel.dart';
import 'package:mrc/widgets/card_default.dart';
import 'package:mrc/widgets/primary_button.dart';
import 'package:mrc/widgets/text_button.dart';
import 'package:mrc/widgets/text_field_default.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({
    Key key,
  }) : super(key: key);

  @override
  _RegisterScreenScreenState createState() => _RegisterScreenScreenState();
}

class _RegisterScreenScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _retypePasswordController = TextEditingController();
  bool _isCaregiver = false;
  String message = "";
  bool buttonEnabled = true;

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
                      onPressed: buttonEnabled ? registerUser : null,
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
          ),
          Text(
            message,
            style: redSmallFont,
          ),
        ],
      ),
    );
  }

  void _handleGoToLogin() {
    Navigator.pushNamed(context, "/");
  }

  void _switchRole(bool value) {
    setState(() {
      _isCaregiver = value;
    });
  }

  Future<void> registerUser() async {
    AuthResult result;

    if (_passwordController.text != _retypePasswordController.text) {
      setState(() {
        message = "Passwords are not the same";
      });
      return;
    }

    setState(() {
      buttonEnabled = false;
    });

    try {
      result = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on Exception catch (e) {
      setState(() {
        message = getExceptionMessage(e);
      });
    }

    if (result != null) {
      setUserData(result.user);
    } else
      setState(() {
        buttonEnabled = true;
      });
  }

  Future<void> setUserData(FirebaseUser user) async {
    await _firestore.collection('users').document().setData({
      "userId": user.uid,
      "role": _isCaregiver ? "caregiver" : "supervisor",
      "mail": _emailController.text,
    });

    setState(() {
      buttonEnabled = true;
    });

    if (_isCaregiver)
      Navigator.pushNamed(context, "/caregiverPanel",
          arguments: CaregiverPanelArguments(user: user));
    else
      Navigator.pushNamed(context, "/supervisorPanel", arguments: user);
  }

  String getExceptionMessage(Exception e) {
    String exceptionMessage = e.toString();
    int startIndex = exceptionMessage.indexOf(",");
    exceptionMessage = exceptionMessage.substring(startIndex + 1);
    int endIndex = exceptionMessage.indexOf(",");
    return exceptionMessage = exceptionMessage.substring(0, endIndex - 1);
  }
}
