import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/screens/caregiver/caregiver_panel.dart';
import 'package:mrc/widgets/card_default.dart';
import 'package:mrc/widgets/primary_button.dart';
import 'package:mrc/widgets/text_button.dart';
import 'package:mrc/widgets/text_field_default.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  _LoginScreenScreenState createState() => _LoginScreenScreenState();
}

class _LoginScreenScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  String message = "";
  bool buttonEnabled = true;

  @override
  void initState() {
    _emailController.text = "c@c.com";
    _passwordController.text = "123456";
    super.initState();
  }

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
                _buildLoginCard(),
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
                      text: "Log in",
                      onPressed: buttonEnabled ? signIn : null,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: TextButton(
                      text: "Register new account",
                      onPressed: _handleGoToRegister,
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

  Widget _buildLoginCard() {
    return CardDefault(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 15),
              child: Text("Login", style: greenBoldFont)),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: TextFieldDefault(
              controller: _emailController,
              hint: "Email address",
            ),
          ),
          TextFieldDefault(
            controller: _passwordController,
            hint: "Password",
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

  void _handleGoToRegister() {
    Navigator.pushNamed(context, "/register");
  }

  Future<void> signIn() async {
    AuthResult result;

    setState(() {
      buttonEnabled = false;
    });

    try {
      result = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on Exception catch (e) {
      setState(() {
        message = getExceptionMessage(e);
      });
    }

    if (result != null) {
      getUserRole(result.user);
    } else
      setState(() {
        buttonEnabled = true;
      });
  }

  Future<void> getUserRole(FirebaseUser user) async {
    _firestore
        .collection('users')
        .where("userId", isEqualTo: user.uid)
        .snapshots()
        .listen((data) =>
            data.documents.forEach((doc) => handleUserRole(doc, user)));
    Timer(
        Duration(seconds: 1),
        () => setState(() {
              message = "User not found";
              buttonEnabled = true;
            }));
  }

  void handleUserRole(DocumentSnapshot doc, FirebaseUser user) {
    setState(() {
      buttonEnabled = false;
    });
    String role = doc["role"];
    if (role == null || (role != "supervisor" && role != "caregiver")) {
      _auth.signOut();
      setState(() {
        message = "This user is neither supervisor nor caregiver";
      });
    } else {
      if (role == "caregiver")
        Navigator.pushNamed(context, "/caregiverPanel",
            arguments: CaregiverPanelArguments(
                user: user, supervisorId: doc["supervisorId"]));
      else if (role == "supervisor")
        Navigator.pushNamed(context, "/supervisorPanel", arguments: user);
    }
    setState(() {
      buttonEnabled = true;
    });
  }

  String getExceptionMessage(Exception e) {
    String exceptionMessage = e.toString();
    int startIndex = exceptionMessage.indexOf(",");
    exceptionMessage = exceptionMessage.substring(startIndex + 1);
    int endIndex = exceptionMessage.indexOf(",");
    return exceptionMessage = exceptionMessage.substring(0, endIndex - 1);
  }
}
