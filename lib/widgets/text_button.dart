import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final TextStyle textStyle;

  TextButton({this.text, this.onPressed, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
