import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/widgets/card_default.dart';
import 'package:mrc/widgets/primary_button.dart';
import 'package:mrc/widgets/text_field_default.dart';

class SupervisorScreen extends StatefulWidget {
  @override
  _SupervisorScreenState createState() => _SupervisorScreenState();
}

class _SupervisorScreenState extends State<SupervisorScreen> {
  bool changesMade = false;

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
    //TODO database save

    setState(() {
      changesMade = false;
      email = emailController.text;
    });
  }

  void addOnChangeListeners() {
    emailController.addListener(() {
      if (emailController.text != email) changesMade = true;
      setState(() {});
    });
  }

  void intializeValues() {
    emailController.text = "arek@buziaczek.edu";
    email = "arek@buziaczek.edu";
    setState(() {});
  }
}
