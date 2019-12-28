import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrc/data/patient_model.dart';

class UserModel {
  String firebaseId;
  String role;
  String patientId;
  String userId;
  String supervisorId;
  String mail;

  UserModel({
    this.firebaseId,
    this.role,
    this.patientId,
    this.supervisorId,
    this.userId,
    this.mail,
  });

  bool isCaregiver() {
    if (role == "supervisor") return false;
    if (role == "caregiver") return true;
    return null;
  }

  static Future<UserModel> getUserById(String userId) async {
    final firestore = Firestore.instance;
    final doc = await firestore.document('users/' + userId).get();

    if (doc == null) return null;
    return documentSnapshotToUserModel(doc);
  }

  static UserModel documentSnapshotToUserModel(DocumentSnapshot doc) {
    return UserModel(
        firebaseId: doc["firebaseId"],
        mail: doc["mail"],
        patientId: doc["patientId"],
        role: doc["role"],
        supervisorId: doc["supervisorId"],
        userId: doc["userId"]);
  }

  static Future<UserModel> registerNewUser(
      String mail, String password, bool isCaregiver, String message) async {
    AuthResult result;
    String userId;
    String patientId;
    final firestore = Firestore.instance;
    final auth = FirebaseAuth.instance;

    try {
      result = await auth.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
    } on Exception catch (e) {
      message = getExceptionMessage(e);
    }

    if (result != null) {
      final doc = firestore.collection('users').document();
      userId = doc.documentID;
      if (!isCaregiver) patientId = PatientModel.createNewPatient();
      await doc.setData({
        "userId": userId,
        "role": isCaregiver ? "caregiver" : "supervisor",
        "mail": mail,
        "patientId": patientId,
        "firebaseId": result.user.uid,
      });
    }

    if (userId == null) return null;
    return UserModel(
      firebaseId: result.user.uid,
      patientId: patientId,
      role: isCaregiver ? "caregiver" : "supervisor",
      mail: mail,
      userId: userId,
    );
  }

  static Future<String> loginUser(
      String mail, String password, Function callback) async {
    final auth = FirebaseAuth.instance;
    String message;
    AuthResult result;

    try {
      result = await auth.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
    } on Exception catch (e) {
      message = getExceptionMessage(e);
    }

    if (result != null) {
      findUserByValue("firebaseID", result.user.uid, callback);
    }

    return message;
  }

  static findUserByValue(String key, String value, Function callback) {
    final firestore = Firestore.instance;
    firestore
        .collection('users')
        .where(key, isEqualTo: value)
        .snapshots()
        .listen((data) => data.documents.forEach((doc) => callback(doc)));
  }

  static Future<void> updateUser(
      String userId, Map<String, dynamic> data) async {
    final firestore = Firestore.instance;
    await firestore.document('user/' + userId).updateData(data);
  }

  static String getExceptionMessage(Exception e) {
    String exceptionMessage = e.toString();
    int startIndex = exceptionMessage.indexOf(",");
    exceptionMessage = exceptionMessage.substring(startIndex + 1);
    int endIndex = exceptionMessage.indexOf(",");
    return exceptionMessage = exceptionMessage.substring(0, endIndex - 1);
  }
}
