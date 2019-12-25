import 'package:mrc/data/question_model.dart';
import 'package:mrc/data/report_model.dart';

List<ReportModel> readyReports() {
  List<ReportModel> readyReports = [];

  List<Question> answeredDietQuestions = ReportModel.dietQuestions();
  answeredDietQuestions.elementAt(0).answer = "Cereals with milk";
  answeredDietQuestions.elementAt(1).answer = "Hotd dog";
  answeredDietQuestions.elementAt(2).answer = "Bean soup";
  answeredDietQuestions.elementAt(3).answer = 3;

  List<Question> hotDogDay = ReportModel.dietQuestions();
  hotDogDay.elementAt(0).answer = "Hotd dog";
  hotDogDay.elementAt(1).answer = "Hotd dog";
  hotDogDay.elementAt(2).answer = "Hotd dog";
  hotDogDay.elementAt(3).answer = 3;

  ReportModel answereDietModelSubmitted = ReportModel(
      submitted: true,
      scheduledDate: DateTime.now(),
      reportType: ReportType.Diet,
      questions: answeredDietQuestions,
      submissionDate: DateTime.now());

  ReportModel hotDogDayModel = ReportModel(
      submitted: true,
      scheduledDate: DateTime.now(),
      reportType: ReportType.Diet,
      questions: hotDogDay,
      submissionDate: DateTime.now());

  ReportModel answereDietModelNotSubmitted = ReportModel(
      submitted: false,
      scheduledDate: DateTime.now(),
      reportType: ReportType.Diet,
      questions: answeredDietQuestions,
      submissionDate: DateTime.now());

  List<Question> badMoodAns = ReportModel.moodQuestions();
  badMoodAns.elementAt(0).answer = "Not very well";
  badMoodAns.elementAt(1).answer = 1;

  List<Question> goodMoodAns = ReportModel.moodQuestions();
  goodMoodAns.elementAt(0).answer = "Fantastic";
  goodMoodAns.elementAt(1).answer = 5;

  ReportModel goodMoodReport = ReportModel(
    submitted: true,
    scheduledDate: DateTime.now(),
    submissionDate: DateTime.now(),
    reportType: ReportType.Mood,
    questions: goodMoodAns,
  );

  ReportModel badMoodReport = ReportModel(
    submitted: true,
    scheduledDate: DateTime.now(),
    submissionDate: DateTime.now(),
    reportType: ReportType.Mood,
    questions: badMoodAns,
  );

  List<Question> medicinesAns = ReportModel.medicinesQuestions();
  medicinesAns.elementAt(0).answer = "Prozac";

  ReportModel medicinesReport = ReportModel(
    submitted: true,
    scheduledDate: DateTime.now(),
    submissionDate: DateTime.now(),
    reportType: ReportType.Medicines,
    questions: medicinesAns,
  );

  readyReports.add(answereDietModelSubmitted);
  readyReports.add(answereDietModelNotSubmitted);
  readyReports.add(hotDogDayModel);
  readyReports.add(goodMoodReport);
  readyReports.add(badMoodReport);
  readyReports.add(medicinesReport);
  readyReports.add(medicinesReport);
  readyReports.add(medicinesReport);

  return readyReports;
}

List<ReportModel> pendingReports() {
  List<ReportModel> pendingReports = [];

  ReportModel reportMood = ReportModel(
    reportType: ReportType.Mood,
    scheduledDate: DateTime.now(),
    questions: ReportModel.moodQuestions(),
  );

  ReportModel reportMedicines = ReportModel(
    reportType: ReportType.Medicines,
    scheduledDate: DateTime.now(),
    questions: ReportModel.medicinesQuestions(),
  );

  pendingReports.add(reportMood);
  pendingReports.add(reportMedicines);
  pendingReports.add(reportMood);
  pendingReports.add(reportMedicines);

  return pendingReports;
}
