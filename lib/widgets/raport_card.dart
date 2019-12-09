import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/data/raport_model.dart';
import 'package:mrc/widgets/card_default.dart';

class RaportCard extends StatelessWidget {
  final RaportModel raport;
  final Function onPress;

  RaportCard({@required this.raport, this.onPress});

  @override
  Widget build(BuildContext context) {
    return CardDefault(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${raport.getName()} - ${getFormattedDate(raport.submissionDate)}",
            style: greenFont,
          ),
          getIcon(),
        ],
      ),
    );
  }

  String getFormattedDate(DateTime date) {
    final format = DateFormat('dd.MM hh:mm');
    return format.format(date);
  }

  Widget getIcon() {
    if (raport.submitted == null) return Container();
    if (raport.submitted)
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
