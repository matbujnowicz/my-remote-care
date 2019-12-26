import 'package:flutter/material.dart';
import 'package:mrc/data/report_model.dart';
import 'package:mrc/screens/common/report_screen.dart';
import 'package:mrc/widgets/fill_report_card.dart';
import 'package:mrc/widgets/report_card.dart';

class DashboardScreen extends StatelessWidget {
  final List<ReportModel> reports;
  DashboardScreen(this.reports);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      child: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0)
            return FillReportCard(
              report: reports.elementAt(index),
              onPress: () {
                fillReport(reports.elementAt(index), context);
              },
            );
          return ReportCard(
            report: reports.elementAt(index),
            onPress: () {
              viewReport(reports.elementAt(index), context);
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
}
