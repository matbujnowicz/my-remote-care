import 'package:flutter/material.dart';
import 'package:mrc/data/report_model.dart';
import 'package:mrc/data/user_model.dart';
import 'package:mrc/screens/common/report_screen.dart';
import 'package:mrc/widgets/primary_button.dart';
import 'package:mrc/widgets/report_card.dart';
import 'package:mrc/screens/supervisor/add_report_screen.dart';

class ManageScreen extends StatelessWidget {
  final List<ReportModel> reports;
  final UserModel user;
  final Function resetState;

  ManageScreen({
    this.reports,
    this.user,
    this.resetState,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      child: ListView.builder(
        itemCount: reports.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0)
            return Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: PrimaryButton(
                text: "Add new report",
                onPressed: () {
                  addReportScreen(context);
                },
              ),
            );
          return ReportCard(
            report: reports.elementAt(index - 1),
            onPress: () {
              viewReport(reports.elementAt(index - 1), context);
            },
            removeObject: () {
              removeReport(reports.elementAt(index - 1));
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

  void addReportScreen(BuildContext context) {
    Navigator.pushNamed(context, '/addReportScreen',
        arguments: AddReportScreenArguments(user: user));
  }

  void removeReport(ReportModel report) async {
    await ReportModel.removeReportFromFirebase(report.reportId);
    resetState();
  }
}
