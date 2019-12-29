import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/data/report_model.dart';
import 'package:mrc/widgets/card_default.dart';

class ReportCard extends StatelessWidget {
  final ReportModel report;
  final Function onPress;
  final Function removeObject;

  ReportCard({@required this.report, this.onPress, this.removeObject});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: CardDefault(
        margin: EdgeInsets.only(bottom: 30),
        padding: EdgeInsets.fromLTRB(20, 5, 15, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "${ReportModel.getName(report.reportType)} - ${getFormattedDate()}",
              style: report.submitted != null && !report.submitted
                  ? accentFont
                  : greenFont,
            ),
            getIcon(),
          ],
        ),
      ),
    );
  }

  String getFormattedDate() {
    final format = DateFormat('dd.MM HH:mm');
    if (report.submissionDate != null)
      return format.format(report.submissionDate);
    else
      return format.format(report.scheduledDate);
  }

  Widget getIcon() {
    if (removeObject != null)
      return IconButton(
        icon: Icon(Icons.remove_circle_outline),
        onPressed: removeObject,
        iconSize: 35,
        color: accentColor,
      );
    if (report.submitted == null)
      return IconButton(
        icon: Icon(Icons.info_outline),
        onPressed: onPress,
        iconSize: 35,
        color: primaryGreenColor,
      );
    if (report.submitted)
      return IconButton(
        iconSize: 35,
        icon: Icon(Icons.check_circle_outline),
        onPressed: onPress,
        color: primaryGreenColor,
      );
    if (!report.submitted)
      return IconButton(
        iconSize: 35,
        icon: Icon(Icons.error_outline),
        onPressed: onPress,
        color: accentColor,
      );
    return Container();
  }
}
