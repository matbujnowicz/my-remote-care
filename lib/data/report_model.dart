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
}
