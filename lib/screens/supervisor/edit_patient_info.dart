import 'package:flutter/material.dart';
import 'package:mrc/data/patient_model.dart';
import 'package:mrc/widgets/patient_card.dart';
import 'package:mrc/widgets/primary_button.dart';

class EditPatientInfoScreen extends StatefulWidget {
  final PatientModel patient;

  EditPatientInfoScreen(this.patient);

  @override
  _EditPatientInfoScreenState createState() => _EditPatientInfoScreenState();
}

class _EditPatientInfoScreenState extends State<EditPatientInfoScreen> {
  bool changesMade = false;

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final yearOfBirthController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  String name = "";
  String surname = "";
  String yearOfBirth = "";
  String height = "";
  String weight = "";

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
            return Container(
              margin: const EdgeInsets.only(top: 30),
              child: PatientCard(
                patient: widget.patient,
                nameController: nameController,
                surnameController: surnameController,
                yearOfBirthController: yearOfBirthController,
                weightController: weightController,
                heightController: heightController,
              ),
            );
          else
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: PrimaryButton(
                onPressed: changesMade ? savePatientInfo : null,
                text: "Save",
              ),
            );
        },
      ),
    );
  }

  void savePatientInfo() {
    widget.patient.name = nameController.text;
    widget.patient.surname = surnameController.text;
    widget.patient.yearOfBirth = yearOfBirthController.text;
    widget.patient.height = heightController.text;
    widget.patient.weight = weightController.text;

    setState(() {
      changesMade = false;
      name = nameController.text;
      surname = surnameController.text;
      yearOfBirth = yearOfBirthController.text;
      height = heightController.text;
      weight = weightController.text;
    });
  }

  void addOnChangeListeners() {
    nameController.addListener(() {
      if (nameController.text != name) changesMade = true;
      setState(() {});
    });
    surnameController.addListener(() {
      if (surnameController.text != surname) changesMade = true;
      setState(() {});
    });
    yearOfBirthController.addListener(() {
      if (yearOfBirthController.text != yearOfBirth) changesMade = true;
      setState(() {});
    });
    heightController.addListener(() {
      if (heightController.text != height) changesMade = true;
      setState(() {});
    });
    weightController.addListener(() {
      if (weightController.text != weight) changesMade = true;
      setState(() {});
    });
  }

  void intializeValues() {
    nameController.text = widget.patient.name;
    surnameController.text = widget.patient.surname;
    yearOfBirthController.text = widget.patient.yearOfBirth;
    heightController.text = widget.patient.height;
    weightController.text = widget.patient.weight;

    name = nameController.text;
    surname = surnameController.text;
    yearOfBirth = yearOfBirthController.text;
    height = heightController.text;
    weight = weightController.text;
    setState(() {});
  }
}
