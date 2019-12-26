import 'package:flutter/material.dart';
import 'package:mrc/data/patient_model.dart';
import 'package:mrc/widgets/patient_card.dart';

class PatientInfoScreen extends StatelessWidget {
  final PatientModel patient;

  PatientInfoScreen(this.patient);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: PatientCard(
              readOnly: true,
              patient: patient,
              nameController: TextEditingController(text: patient.name),
              surnameController: TextEditingController(text: patient.surname),
              yearOfBirthController:
                  TextEditingController(text: patient.yearOfBirth),
              heightController: TextEditingController(text: patient.height),
              weightController: TextEditingController(text: patient.weight),
            ),
          );
        },
      ),
    );
  }
}
