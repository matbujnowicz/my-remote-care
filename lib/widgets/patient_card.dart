import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/data/patient_model.dart';
import 'package:mrc/widgets/card_default.dart';
import 'package:mrc/widgets/text_field_default.dart';

class PatientCard extends StatelessWidget {
  final bool readOnly;
  final PatientModel patient;
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController yearOfBirthController;
  final TextEditingController heightController;
  final TextEditingController weightController;

  PatientCard(
      {this.patient,
      this.readOnly = false,
      this.nameController,
      this.surnameController,
      this.yearOfBirthController,
      this.heightController,
      this.weightController});

  @override
  Widget build(BuildContext context) {
    return CardDefault(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              "Name",
              style: greenBoldFont,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: TextFieldDefault(
              controller: nameController,
              enabled: !readOnly,
              hint: "Name",
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              "Surname",
              style: greenBoldFont,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: TextFieldDefault(
              controller: surnameController,
              enabled: !readOnly,
              hint: "Surname",
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              "Year of birth",
              style: greenBoldFont,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: TextFieldDefault(
              controller: yearOfBirthController,
              enabled: !readOnly,
              hint: "Year of birth",
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              "Height",
              style: greenBoldFont,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: TextFieldDefault(
              controller: heightController,
              enabled: !readOnly,
              hint: "Height in centimeters",
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              "Weight",
              style: greenBoldFont,
            ),
          ),
          Container(
            child: TextFieldDefault(
              controller: weightController,
              enabled: !readOnly,
              hint: "Weight in kilograms",
            ),
          ),
        ],
      ),
    );
  }
}
