import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/data/user_model.dart';
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
            height: screenHeight,
            child: Column(
              children: <Widget>[
                Container(
                  height:
                      screenHeight - MediaQuery.of(context).viewInsets.bottom,
                  width: screenWidth * 0.9,
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0)
                        return CardDefault(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "My Remote Care",
                              style: greenBoldFont.copyWith(fontSize: 30),
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 20),
                        );
                      if (index == 1) return _buildRegisterCard();
                      if (index == 2)
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: PrimaryButton(
                                text: "Register",
                                onPressed: buttonEnabled ? registerUser : null,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: TextButton(
                                text: "Log in to existing account",
                                onPressed: _handleGoToLogin,
                                textStyle: accentFont,
                                pressedTextStyle: grayFont,
                              ),
                            ),
                          ],
                        );
                      return Container();
                    },
                  ),
                ),
              ],
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
    UserModel user;

    if (_passwordController.text != _retypePasswordController.text) {
      setMessage("Passwords are not the same");
      return;
    }

    setState(() {
      buttonEnabled = false;
    });

    user = await UserModel.registerNewUser(_emailController.text,
        _passwordController.text, _isCaregiver, setMessage);
    if (user == null) {
      setState(() {
        buttonEnabled = true;
      });
    } else {
      if (user.isCaregiver())
        Navigator.pushNamed(context, "/caregiverPanel", arguments: user);
      else
        Navigator.pushNamed(context, "/supervisorPanel", arguments: user);
    }
  }

  void setMessage(String newMessage) {
    setState(() {
      buttonEnabled = true;
      message = newMessage;
    });
  }
}
