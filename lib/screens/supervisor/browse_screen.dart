import 'package:flutter/material.dart';
import 'package:mrc/data/raport_model.dart';
import 'package:mrc/widgets/raport_card.dart';

class BrowseScreen extends StatelessWidget {
  final List<RaportModel> raports;
  BrowseScreen(this.raports);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      child: ListView.builder(
        itemCount: raports.length,
        itemBuilder: (BuildContext context, int index) {
          return RaportCard(raport: raports.elementAt(index));
        },
      ),
    );
  }
}
