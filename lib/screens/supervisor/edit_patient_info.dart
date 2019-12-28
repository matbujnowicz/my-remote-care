import 'package:flutter/material.dart';
import 'package:mrc/data/patient_model.dart';
import 'package:mrc/data/user_model.dart';
import 'package:mrc/widgets/patient_card.dart';
import 'package:mrc/widgets/primary_button.dart';

class EditPatientInfoScreen extends StatefulWidget {
  final UserModel user;

  EditPatientInfoScreen(this.user);

  @override
  _EditPatientInfoScreenState createState() => _EditPatientInfoScreenState();
}

class _EditPatientInfoScreenState extends State<EditPatientInfoScreen> {
  PatientModel patient;

  bool changesMade = false;

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final yearOfBirthController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

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
                patient: patient,
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

  void savePatientInfo() async {
    patient.name = nameController.text;
    patient.surname = surnameController.text;
    patient.yearOfBirth = yearOfBirthController.text;
    patient.height = heightController.text;
    patient.weight = weightController.text;

    changesMade = false;
    setState(() {});
    await PatientModel.savePatientInfoInFirebase(
        patient, widget.user.patientId);
  }

  void addOnChangeListeners() {
    nameController.addListener(() {
      if (nameController.text != patient.name) changesMade = true;
      setState(() {});
    });
    surnameController.addListener(() {
      if (surnameController.text != patient.surname) changesMade = true;
      setState(() {});
    });
    yearOfBirthController.addListener(() {
      if (yearOfBirthController.text != patient.yearOfBirth) changesMade = true;
      setState(() {});
    });
    heightController.addListener(() {
      if (heightController.text != patient.height) changesMade = true;
      setState(() {});
    });
    weightController.addListener(() {
      if (weightController.text != patient.weight) changesMade = true;
      setState(() {});
    });
  }

  void intializeValues() async {
    if (widget.user.patientId == null) return;

    patient = await PatientModel.getPatient(widget.user.patientId);

    nameController.text = patient.name;
    surnameController.text = patient.surname;
    yearOfBirthController.text = patient.yearOfBirth;
    heightController.text = patient.height;
    weightController.text = patient.weight;

    setState(() {});
  }
}
