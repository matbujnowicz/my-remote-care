import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/data/report_model.dart';
import 'package:mrc/widgets/card_default.dart';

class ReportCard extends StatelessWidget {
  final ReportModel report;
  final Function onPress;

  ReportCard({@required this.report, this.onPress});

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
              "${report.getName()} - ${getFormattedDate(report.submissionDate)}",
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

  String getFormattedDate(DateTime date) {
    final format = DateFormat('dd.MM hh:mm');
    return format.format(date);
  }

  Widget getIcon() {
    if (report.submitted == null) return Container();
    if (report.submitted)
      return IconButton(
        iconSize: 35,
        icon: Icon(Icons.check_circle_outline),
        onPressed: () {},
        color: primaryGreenColor,
      );
    else
      return IconButton(
        iconSize: 35,
        icon: Icon(Icons.error_outline),
        onPressed: () {},
        color: accentColor,
      );
  }
}
