import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/data/report_model.dart';
import 'package:mrc/screens/common/report_screen.dart';
import 'package:mrc/screens/common/single_screen.dart';
import 'package:mrc/widgets/card_default.dart';
import 'package:mrc/widgets/date_time_picker_default.dart';
import 'package:mrc/widgets/dropdown_default.dart';
import 'package:mrc/widgets/primary_button.dart';
import 'package:mrc/widgets/report_card.dart';

class AddReportScreenArguments {
  final FirebaseUser user;

  AddReportScreenArguments({this.user});
}

class AddReportScreen extends StatefulWidget {
  final AddReportScreenArguments arguments;
  AddReportScreen({
    Key key,
    this.arguments,
  }) : super(key: key);

  @override
  _AddReportScreenState createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  ReportModel report = ReportModel();
  bool buttonEnabled = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleScreen(
      SingleScreenArguments(
        title: "Add report",
        child: Container(
          width: 0.9 * screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  CardDefault(
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Text(
                            "Choose report type",
                            style: greenBoldFont,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 15),
                          child: buildDropdown(),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Text(
                            "Schedule report submission time",
                            style: greenBoldFont,
                          ),
                        ),
                        DateTimePickerDefault(
                          onDatePicked: onDatePicked,
                          valueDate: report.scheduledDate,
                        )
                      ],
                    ),
                  ),
                  if (buttonEnabled)
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: ReportCard(
                        report: report,
                        onPress: () {
                          viewReport(report, context);
                        },
                      ),
                    ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: PrimaryButton(
                  text: "Add new report",
                  onPressed: buttonEnabled
                      ? () {
                          addReport(context);
                        }
                      : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdown() {
    final items = ReportType.values
        .map<DropdownMenuItem<ReportType>>(
          (ReportType type) => DropdownMenuItem<ReportType>(
            value: type,
            child: Text(
              ReportModel.getName(type),
            ),
          ),
        )
        .toList();

    return DropdownDefault(
      items: items,
      value: report.reportType == null ? null : report.reportType,
      onChanged: onDropdownChanged,
    );
  }

  void onDropdownChanged(ReportType type) {
    setState(() {
      report.setType(type);
    });
    isButtonActive();
  }

  void isButtonActive() {
    if (report.reportType != null && report.scheduledDate != null)
      buttonEnabled = true;
    else
      buttonEnabled = false;
    setState(() {});
  }

  void onDatePicked(DateTime newDate) {
    setState(() {
      report.scheduledDate = newDate;
    });
    isButtonActive();
  }

  Future<void> addReport(BuildContext context) async {
    setState(() {
      buttonEnabled = false;
    });
    await ReportModel.addReportToFirebase(report, widget.arguments.user.uid);
    Navigator.pop(context);
  }

  void viewReport(ReportModel report, BuildContext context) {
    Navigator.pushNamed(context, "/reportScreen",
        arguments: ReportScreenArguments(report: report, readOnly: true));
  }
}
