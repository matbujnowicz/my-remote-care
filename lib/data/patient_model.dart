import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  String name;
  String surname;
  String yearOfBirth;
  String height;
  String weight;

  PatientModel(
      {this.name, this.surname, this.yearOfBirth, this.height, this.weight});

  static Future<void> savePatientInfoInFirebase(
      PatientModel patient, String patientId) async {
    final firestore = Firestore.instance;
    await firestore.document('patients/' + patientId).updateData({
      "name": patient.name,
      "surname": patient.surname,
      "yearOfBirth": patient.yearOfBirth,
      "height": patient.height,
      "weight": patient.weight,
    });
  }

  static Future<String> createNewPatient() async {
    final firestore = Firestore.instance;
    final doc = firestore.collection('patients').document();
    await doc.setData({"name": ""});
    return doc.documentID;
  }

  static Future<PatientModel> getPatient(String patientId) async {
    final firestore = Firestore.instance;
    final doc = await firestore.document('patients/' + patientId).get();
    return PatientModel(
      name: doc["name"],
      surname: doc["surname"],
      yearOfBirth: doc["yearOfBirth"],
      height: doc["height"],
      weight: doc["weight"],
    );
  }
}
