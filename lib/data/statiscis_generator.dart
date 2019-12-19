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
  Map<String, String> statistics = Map();
  Map<ReportType, bool> existingTypes = generateExistingTypes(reports);

  if (existingTypes[ReportType.Diet]) {
    statistics.putIfAbsent("Favourite meal", () => "Favourite meal");
    statistics["Favourite meal"] = favouriteMeal(reports);
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
        mealsOccurence.putIfAbsent(question.answer, () => question.answer);
        mealsOccurence[question.answer] = 1;
      }
    });
  });

  //TODO return max occurence meal
  return null;
}
