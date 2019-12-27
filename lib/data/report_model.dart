import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mrc/data/question_model.dart';

enum ReportType {
  Mood,
  Diet,
  Medicines,
}

class ReportModel {
  bool submitted;
  DateTime scheduledDate;
  DateTime submissionDate;
  Duration duration = Duration(hours: 1);
  ReportType reportType;
  List<Question> questions;
  String reportId;

  ReportModel({
    this.scheduledDate,
    this.reportType,
    this.submitted,
    this.submissionDate,
    this.questions,
    this.reportId,
  }) {
    if (questions == null)
      switch (reportType) {
        case ReportType.Diet:
          questions = dietQuestions();
          break;
        case ReportType.Mood:
          questions = moodQuestions();
          break;
        case ReportType.Medicines:
          questions = medicinesQuestions();
          break;
        default:
      }
  }

  void setType(ReportType type) {
    reportType = type;
    switch (type) {
      case ReportType.Diet:
        questions = dietQuestions();
        break;
      case ReportType.Mood:
        questions = moodQuestions();
        break;
      case ReportType.Medicines:
        questions = medicinesQuestions();
        break;
      default:
    }
  }

  static String getName(ReportType reportType) {
    switch (reportType) {
      case ReportType.Diet:
        return "Diet";
      case ReportType.Mood:
        return "Mood";
      case ReportType.Medicines:
        return "Medicines";
      default:
        return "";
    }
  }

  static ReportType getTypeFromString(String type) {
    switch (type) {
      case "Diet":
        return ReportType.Diet;
      case "Mood":
        return ReportType.Mood;
      case "Medicines":
        return ReportType.Medicines;
      default:
        return null;
    }
  }

  static List<Question> dietQuestions() {
    return [
      Question(questionType: QuestionType.Text, question: "Breakfast"),
      Question(questionType: QuestionType.Text, question: "Lunch"),
      Question(questionType: QuestionType.Text, question: "Dinner"),
      Question(
          questionType: QuestionType.Radio,
          question: "Rate patient's appetite"),
    ];
  }

  static List<Question> moodQuestions() {
    return [
      Question(
          questionType: QuestionType.Text, question: "Describe patient's mood"),
      Question(
          questionType: QuestionType.Radio, question: "Rate patient's mood"),
    ];
  }

  static List<Question> medicinesQuestions() {
    return [
      Question(
          questionType: QuestionType.Text,
          question: "What medicines has patient taken today?"),
    ];
  }

  static Future<void> addReportToFirebase(
      ReportModel report, String userId) async {
    final firestore = Firestore.instance;
    await firestore.collection('reports').document().setData({
      "reportType": getName(report.reportType),
      "scheduledDate": report.scheduledDate,
      "userId": userId,
    });
  }

  static void getReportsFromFirebase(
      String userId, List<ReportModel> reports, Function resetState) {
    final firestore = Firestore.instance;
    firestore
        .collection('reports')
        .where("userId", isEqualTo: userId)
        .snapshots()
        .listen((data) => addReportsToList(data, reports, resetState));
  }

  static void addReportsToList(
      QuerySnapshot data, List<ReportModel> reports, Function resetState) {
    reports.clear();
    data.documents.forEach((doc) => addReportToList(doc, reports));
    resetState();
  }

  static void addReportToList(DocumentSnapshot doc, List<ReportModel> reports) {
    final newReport = ReportModel(
      reportType: getTypeFromString(doc["reportType"]),
      submitted: doc["submitted"],
      scheduledDate: doc["scheduledDate"].toDate(),
      submissionDate:
          doc["submissionDate"] == null ? null : doc["submissionDate"].toDate(),
      reportId: doc.documentID,
    );
    int index = 0;
    if (doc["answers"] != null)
      doc["answers"].forEach((answer) {
        newReport.questions[index].answer = answer;
        index++;
      });
    reports.add(newReport);
  }

  static Future<void> removeReportFromFirebase(String reportId) async {
    final firestore = Firestore.instance;
    await firestore.document('reports/' + reportId).delete();
  }

  static List<ReportModel> scheduledReports(List<ReportModel> reports) {
    List<ReportModel> scheduledReports = List();
    reports.forEach((report) {
      if (report.submitted == null) scheduledReports.add(report);
    });
    return scheduledReports;
  }

  static List<ReportModel> submittedReports(List<ReportModel> reports) {
    List<ReportModel> submittedReports = List();
    reports.forEach((report) {
      if (report.submitted != null) submittedReports.add(report);
    });
    return submittedReports;
  }
}
