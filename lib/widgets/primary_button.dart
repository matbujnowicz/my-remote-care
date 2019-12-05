import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  PrimaryButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ButtonTheme(
      minWidth: 0.9 * screenWidth,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(text, style: whiteFont.copyWith(fontSize: 22)),
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10),
        ),
      ),
    );
  }
}
