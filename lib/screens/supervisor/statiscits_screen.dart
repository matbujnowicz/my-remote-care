import 'package:flutter/material.dart';
import 'package:mrc/data/report_model.dart';

class StatisticsScreen extends StatelessWidget {
  final List<ReportModel> reports;

  StatisticsScreen(this.reports);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {},
      ),
    );
  }
}
