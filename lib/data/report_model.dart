import 'package:flutter/material.dart';

enum ReportType {
  Mood,
  Diet,
  Medicines,
}

enum QuestionType {
  Text,
  Radio,
}

class ReportModel {
  bool submitted;
  DateTime scheduledDate;
  DateTime submissionDate;
  Duration duration = Duration(hours: 1);
  ReportType reportType;
  List<Question> questions;

  ReportModel({
    this.scheduledDate,
    this.reportType,
    this.submitted,
    this.submissionDate,
    this.questions,
  }) {
    if (questions == null)
      switch (reportType) {
        case ReportType.Diet:
          questions = dietQuestions;
          break;
        case ReportType.Mood:
          questions = moodQuestions;
          break;
        case ReportType.Medicines:
          questions = medicinesQuestions;
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
}

class Question {
  QuestionType questionType;
  String question;
  dynamic answer;

  Question({@required this.questionType, @required this.question, this.answer});
}

List<Question> dietQuestions = [
  Question(questionType: QuestionType.Text, question: "Breakfast"),
  Question(questionType: QuestionType.Text, question: "Lunch"),
  Question(questionType: QuestionType.Text, question: "Dinner"),
  Question(
      questionType: QuestionType.Radio, question: "Rate patient's appetite"),
];

List<Question> moodQuestions = [
  Question(
      questionType: QuestionType.Text, question: "Describe patient's mood"),
  Question(questionType: QuestionType.Radio, question: "Rate patient's mood"),
];

List<Question> medicinesQuestions = [
  Question(
      questionType: QuestionType.Text,
      question: "What medicines has patient taken today?"),
];

List<ReportModel> initialReports() {
  List<ReportModel> initialReportsMock = [];

  List<Question> answeredDietQuestions = dietQuestions;
  answeredDietQuestions.elementAt(0).answer = "Cereals with milk";
  answeredDietQuestions.elementAt(1).answer = "Hotd dog";
  answeredDietQuestions.elementAt(2).answer = "Bean soup";
  answeredDietQuestions.elementAt(3).answer = 3;

  ReportModel answereDietModelSubmitted = ReportModel(
      submitted: true,
      scheduledDate: DateTime.now(),
      reportType: ReportType.Diet,
      questions: answeredDietQuestions,
      submissionDate: DateTime.now());

  ReportModel answereDietModelNotSubmitted = ReportModel(
      submitted: false,
      scheduledDate: DateTime.now(),
      reportType: ReportType.Diet,
      questions: answeredDietQuestions,
      submissionDate: DateTime.now());

  initialReportsMock.add(answereDietModelSubmitted);
  initialReportsMock.add(answereDietModelNotSubmitted);

  return initialReportsMock;
}

List<ReportModel> notInitialReports() {
  List<ReportModel> initialReportsMock = [];

  ReportModel reportMood = ReportModel(
    reportType: ReportType.Mood,
    scheduledDate: DateTime.now(),
    questions: moodQuestions,
  );

  ReportModel reportMedicines = ReportModel(
    reportType: ReportType.Medicines,
    scheduledDate: DateTime.now(),
    questions: medicinesQuestions,
  );

  initialReportsMock.add(reportMood);
  initialReportsMock.add(reportMedicines);
  initialReportsMock.add(reportMood);
  initialReportsMock.add(reportMedicines);

  return initialReportsMock;
}
