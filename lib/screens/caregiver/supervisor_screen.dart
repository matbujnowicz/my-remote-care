import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/widgets/card_default.dart';
import 'package:mrc/widgets/primary_button.dart';
import 'package:mrc/widgets/text_field_default.dart';

import 'caregiver_panel.dart';

class SupervisorScreen extends StatefulWidget {
  final String supervisorId;
  final FirebaseUser user;
  SupervisorScreen({this.supervisorId, this.user});

  @override
  _SupervisorScreenState createState() => _SupervisorScreenState();
}

class _SupervisorScreenState extends State<SupervisorScreen> {
  bool changesMade = false;
  final _firestore = Firestore.instance;
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

  void intializeValues() {
    if (widget.supervisorId != null) {
      getUserMail(widget.supervisorId);
    }
  }

  Future<void> getUserMail(String userId) async {
    _firestore
        .collection('users')
        .where("userId", isEqualTo: userId)
        .snapshots()
        .listen((data) => data.documents.forEach((doc) => setState(() {
              email = doc["mail"];
              emailController.text = doc["mail"];
            })));
  }

  void saveSupervisorIdByEmail(String mail) {
    _firestore
        .collection('users')
        .where("mail", isEqualTo: mail)
        .snapshots()
        .listen(
            (data) => data.documents.forEach((doc) => setSupervisorId(doc)));
  }

  void setSupervisorId(DocumentSnapshot supervisorDoc) {
    if (supervisorDoc["role"] != "supervisor") {
      setState(() {
        message = "This email does not belong to a supervisor";
      });
      return;
    }
    _firestore
        .collection('users')
        .where("userId", isEqualTo: widget.user.uid)
        .snapshots()
        .listen((data) => data.documents.forEach((doc) {
              _firestore
                  .document('users/' + doc.documentID)
                  .updateData({"supervisorId": supervisorDoc["userId"]});
            }));
    Navigator.pushReplacementNamed(context, "/caregiverPanel",
        arguments: CaregiverPanelArguments(
            user: widget.user, supervisorId: supervisorDoc["userId"]));
  }
}
