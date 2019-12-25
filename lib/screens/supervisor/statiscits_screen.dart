import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/data/report_model.dart';
import 'package:mrc/widgets/card_default.dart';

class StatisticsScreen extends StatelessWidget {
  final List<ReportModel> reports;
  final Map<String, String> statistics;

  StatisticsScreen(this.reports, this.statistics);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.9,
      child: ListView.builder(
        itemCount: statistics.length,
        itemBuilder: (BuildContext context, int index) {
          String description = statistics.entries.elementAt(index).key;
          String value = statistics.entries.elementAt(index).value;
          return CardDefault(
            margin: EdgeInsets.only(bottom: 30),
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    description,
                    style: greenBoldFont,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    value,
                    style: greenFont,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
