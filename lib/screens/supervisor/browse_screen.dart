import 'package:flutter/material.dart';
import 'package:mrc/data/report_model.dart';
import 'package:mrc/screens/common/report_screen.dart';
import 'package:mrc/widgets/report_card.dart';

class BrowseScreen extends StatelessWidget {
  final List<ReportModel> reports;
  BrowseScreen(this.reports);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      child: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (BuildContext context, int index) {
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
}
