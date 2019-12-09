import 'package:flutter/material.dart';

enum RaportType {
  Mood,
  Diet,
  Medicines,
}

enum QuestionType {
  Text,
  Radio,
}

class RaportModel {
  bool submitted;
  DateTime scheduledDate;
  DateTime submissionDate;
  Duration duration = Duration(hours: 1);
  RaportType raportType;
  List<Question> questions;

  RaportModel({
    @required this.scheduledDate,
    @required this.raportType,
    this.submitted,
    this.submissionDate,
    this.questions,
  }) {
    if (questions == null)
      switch (raportType) {
        case RaportType.Diet:
          questions = dietQuestions;
          break;
        case RaportType.Mood:
          questions = moodQuestions;
          break;
        case RaportType.Medicines:
          questions = medicinesQuestions;
          break;
        default:
      }
  }

  String getName() {
    switch (raportType) {
      case RaportType.Diet:
        return "Diet";
      case RaportType.Mood:
        return "Diet";
      case RaportType.Medicines:
        return "Diet";
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

List<RaportModel> initialRaports() {
  List<RaportModel> initialRaportsMock = [];

  List<Question> answeredDietQuestions = dietQuestions;
  answeredDietQuestions.elementAt(0).answer = "Cereals with milk";
  answeredDietQuestions.elementAt(1).answer = "Hotd dog";
  answeredDietQuestions.elementAt(2).answer = "Bean soup";
  answeredDietQuestions.elementAt(3).answer = 3;

  RaportModel answereDietModelSubmitted = RaportModel(
      submitted: true,
      scheduledDate: DateTime.now(),
      raportType: RaportType.Diet,
      questions: answeredDietQuestions,
      submissionDate: DateTime.now());

  RaportModel answereDietModelNotSubmitted = RaportModel(
      submitted: false,
      scheduledDate: DateTime.now(),
      raportType: RaportType.Diet,
      questions: answeredDietQuestions,
      submissionDate: DateTime.now());

  initialRaportsMock.add(answereDietModelSubmitted);
  initialRaportsMock.add(answereDietModelNotSubmitted);

  return initialRaportsMock;
}
