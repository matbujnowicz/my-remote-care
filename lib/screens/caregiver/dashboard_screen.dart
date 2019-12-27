import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrc/data/report_model.dart';
import 'package:mrc/screens/common/report_screen.dart';
import 'package:mrc/widgets/fill_report_card.dart';
import 'package:mrc/widgets/report_card.dart';

class DashboardScreen extends StatelessWidget {
  final List<ReportModel> reports;
  final Function resetState;
  DashboardScreen({
    this.reports,
    this.resetState,
  });
  final firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      child: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (BuildContext context, int index) {
          ReportModel currentReport = reports.elementAt(index);
          if (examineReport(currentReport))
            return FillReportCard(
              report: currentReport,
              onPress: () {
                fillReport(currentReport, context);
              },
            );
          return ReportCard(
            report: currentReport,
            onPress: () {
              viewReport(currentReport, context);
            },
          );
        },
      ),
    );
  }

  void viewReport(ReportModel report, BuildContext context) {
    Navigator.pushNamed(context, "/reportScreen",
        arguments: ReportScreenArguments(report: report, readOnly: true));
  }

  void fillReport(ReportModel report, BuildContext context) {
    Navigator.pushNamed(context, "/reportScreen",
        arguments: ReportScreenArguments(report: report, readOnly: false));
  }

  bool examineReport(ReportModel report) {
    if (DateTime.now().compareTo(report.scheduledDate) >= 0) {
      if (DateTime.now().compareTo(report.scheduledDate.add(report.duration)) >
          0)
        markReportAsNotSubmitted(report);
      else
        return true;
    }
    return false;
  }

  void markReportAsNotSubmitted(ReportModel report) async {
    await firestore
        .document('reports/' + report.reportId)
        .updateData({"submitted": false});
  }
}
