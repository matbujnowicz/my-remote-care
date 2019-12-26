import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/data/report_model.dart';
import 'package:mrc/widgets/card_default.dart';

class FillReportCard extends StatelessWidget {
  final ReportModel report;
  final Function onPress;
  final Function removeObject;

  FillReportCard({@required this.report, this.onPress, this.removeObject});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: CardDefault(
        color: accentColor,
        margin: EdgeInsets.only(bottom: 30),
        padding: EdgeInsets.fromLTRB(20, 5, 15, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "${ReportModel.getName(report.reportType)} - FILL NOW",
              style: whiteBoldFont,
            ),
            getIcon(),
          ],
        ),
      ),
    );
  }

  Widget getIcon() {
    return IconButton(
      iconSize: 35,
      icon: Icon(Icons.add_circle_outline),
      onPressed: onPress,
      color: whiteColor,
    );
  }
}
