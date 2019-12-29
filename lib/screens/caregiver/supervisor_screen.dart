import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/data/user_model.dart';
import 'package:mrc/widgets/card_default.dart';
import 'package:mrc/widgets/primary_button.dart';
import 'package:mrc/widgets/text_field_default.dart';

class SupervisorScreen extends StatefulWidget {
  final UserModel user;
  SupervisorScreen({this.user});

  @override
  _SupervisorScreenState createState() => _SupervisorScreenState();
}

class _SupervisorScreenState extends State<SupervisorScreen> {
  bool changesMade = false;
  String message = "";

  final emailController = TextEditingController();

  String email = "";

  @override
  void initState() {
    super.initState();

    intializeValues();
    addOnChangeListeners();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0)
            return CardDefault(
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Supervisor email",
                      style: greenBoldFont,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: TextFieldDefault(
                      controller: emailController,
                      hint: "Email",
                    ),
                  ),
                  Text(
                    message,
                    style: redSmallFont,
                  ),
                ],
              ),
            );
          else
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: PrimaryButton(
                onPressed: changesMade ? saveEmail : null,
                text: "Save",
              ),
            );
        },
      ),
    );
  }

  void saveEmail() {
    setState(() {
      changesMade = false;
      email = emailController.text;
    });
    saveSupervisorIdByEmail(emailController.text);
  }

  void addOnChangeListeners() {
    emailController.addListener(() {
      if (emailController.text != email) changesMade = true;
      setState(() {});
    });
  }

  void intializeValues() async {
    if (widget.user.supervisorId != null) {
      final supervisorUser =
          await UserModel.getUserById(widget.user.supervisorId);
      setState(() {
        email = supervisorUser.mail;
        emailController.text = supervisorUser.mail;
      });
    }
  }

  void saveSupervisorIdByEmail(String mail) {
    message = "";
    UserModel.findUserByValue("mail", mail, saveSupervisorToThisUser);
    Timer(Duration(seconds: 3), () {
      if (message == "")
        setState(() {
          message = "Timeout reached -> user not found";
        });
    });
  }

  void saveSupervisorToThisUser(DocumentSnapshot supervisorDoc) async {
    UserModel supervisorUser =
        UserModel.documentSnapshotToUserModel(supervisorDoc);
    if (supervisorUser == null ||
        supervisorUser.userId == null ||
        supervisorUser.role == null) {
      setState(() {
        message = "Wrong user";
      });
    } else if (supervisorUser.isCaregiver()) {
      setState(() {
        message = "This email does not belong to a supervisor";
      });
    } else {
      setState(() {
        message = "Supervisor saved";
      });
      await UserModel.updateUser(widget.user.userId, {
        "supervisorId": supervisorUser.userId,
        "patientId": supervisorUser.patientId
      });
    }
  }
}
