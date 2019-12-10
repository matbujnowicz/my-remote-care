import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';

class RadioInput extends StatefulWidget {
  final TextEditingController controller;

  RadioInput({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  _RadioInputState createState() => _RadioInputState();
}

class _RadioInputState extends State<RadioInput> {
  int groupValue;

  @override
  void initState() {
    setState(() {
      groupValue = int.tryParse(widget.controller.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              "1",
              style: greenFont,
            ),
            Radio(
              value: 1,
              groupValue: groupValue,
              onChanged: (value) {
                changeGroupValue(value);
              },
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              "2",
              style: greenFont,
            ),
            Radio(
              value: 2,
              groupValue: groupValue,
              onChanged: (value) {
                changeGroupValue(value);
              },
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              "3",
              style: greenFont,
            ),
            Radio(
              value: 3,
              groupValue: groupValue,
              onChanged: (value) {
                changeGroupValue(value);
              },
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              "4",
              style: greenFont,
            ),
            Radio(
              value: 4,
              groupValue: groupValue,
              onChanged: (value) {
                changeGroupValue(value);
              },
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              "5",
              style: greenFont,
            ),
            Radio(
              value: 5,
              groupValue: groupValue,
              onChanged: (value) {
                changeGroupValue(value);
              },
            ),
          ],
        ),
      ],
    );
  }

  void changeGroupValue(int value) {
    setState(() {
      groupValue = value;
    });
  }
}
