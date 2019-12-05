import 'package:flutter/material.dart';

class TextButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final TextStyle textStyle;
  final TextStyle pressedTextStyle;

  TextButton(
      {this.text, this.onPressed, this.textStyle, this.pressedTextStyle});

  @override
  _TextButtonState createState() => _TextButtonState();
}

class _TextButtonState extends State<TextButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedDefaultTextStyle(
        style: pressed ? widget.pressedTextStyle : widget.textStyle,
        duration: const Duration(milliseconds: 1),
        child: Text(
          widget.text,
        ),
      ),
    );
  }

  void onTap() {
    setState(() {
      pressed = true;
    });
    widget.onPressed();
  }
}
