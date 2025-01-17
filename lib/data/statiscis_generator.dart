import 'package:mrc/data/question_model.dart';
import 'package:mrc/data/report_model.dart';
import 'dart:core';

Map<ReportType, bool> generateExistingTypes(List<ReportModel> reports) {
  Map<ReportType, bool> existingTypes = {
    ReportType.Diet: false,
    ReportType.Medicines: false,
    ReportType.Mood: false,
  };

  reports.forEach((report) {
    existingTypes[report.reportType] = true;
  });

  return existingTypes;
}

Map<String, String> generateStatistics(List<ReportModel> reports) {
  final submittedReports = getSubmittedReports(reports);
  Map<String, String> statistics = Map();
  if (submittedReports.length == 0) return statistics;
  Map<ReportType, bool> existingTypes = generateExistingTypes(submittedReports);

  statistics.putIfAbsent(
      "Caregiver effectiveness", () => effectiveness(submittedReports));

  if (existingTypes[ReportType.Diet]) {
    statistics.putIfAbsent(
        "Favourite meal", () => favouriteMeal(submittedReports));
  }

  if (existingTypes[ReportType.Mood]) {
    statistics.putIfAbsent("Average mood", () => averageMood(submittedReports));
  }

  if (existingTypes[ReportType.Medicines]) {
    statistics.putIfAbsent("Number of medicines reports",
        () => medicinesReportsCount(submittedReports));
  }

  return statistics;
}

String favouriteMeal(List<ReportModel> reports) {
  Map<String, int> mealsOccurence = Map();

  reports.forEach((report) {
    if (report.reportType != ReportType.Diet) return;
    report.questions.forEach((question) {
      if (question.questionType != QuestionType.Text) return;
      if (mealsOccurence.containsKey(question.answer))
        mealsOccurence[question.answer]++;
      else {
        mealsOccurence.putIfAbsent(question.answer, () => 1);
      }
    });
  });

  String favMeal;
  int topOccurence = 0;
  mealsOccurence.forEach((meal, occurence) {
    if (topOccurence < occurence) {
      topOccurence = occurence;
      favMeal = meal;
    }
  });

  return favMeal;
}

String averageMood(List<ReportModel> reports) {
  double averageMood = 0;
  int moodReportscount = 0;

  reports.forEach((report) {
    if (report.reportType != ReportType.Mood) return;
    moodReportscount++;
    averageMood += int.tryParse(report.questions[1].answer);
  });

  return (averageMood / moodReportscount).toString();
}

String medicinesReportsCount(List<ReportModel> reports) {
  int reportsCount = 0;

  reports.forEach((report) {
    if (report.reportType != ReportType.Medicines) return;
    reportsCount++;
  });

  return reportsCount.toString();
}

String effectiveness(List<ReportModel> reports) {
  double submittedReports = 0;

  reports.forEach((report) {
    if (report.submitted) submittedReports++;
  });

  submittedReports /= reports.length;
  submittedReports *= 100;

  return "${submittedReports.floor()}%".toString();
}

List<ReportModel> getSubmittedReports(List<ReportModel> reports) {
  List<ReportModel> submittedReports = List();
  reports.forEach((report) {
    if (report.submitted) submittedReports.add(report);
  });
  return submittedReports;
}
