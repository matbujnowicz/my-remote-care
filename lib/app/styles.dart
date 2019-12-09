import 'package:flutter/material.dart';

const backgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color.fromARGB(255, 0, 255, 244),
    Color.fromARGB(255, 0, 255, 178),
  ],
);

final primaryGreenColor = Color.fromARGB(255, 0, 149, 131);
final grayColor = Color.fromARGB(255, 198, 198, 198);
final accentColor = Color.fromARGB(255, 231, 66, 146);
final accentDarkerColor = Color.fromARGB(255, 133, 28, 79);
final whiteColor = Colors.white;

final greenFont = TextStyle(
  color: primaryGreenColor,
  fontSize: 18.0,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
);

final whiteFont = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
);

final accentFont = TextStyle(
  color: accentColor,
  fontSize: 18.0,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
);

final grayFont = TextStyle(
  color: grayColor,
  fontSize: 18.0,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
);

final greenBoldFont = TextStyle(
  color: primaryGreenColor,
  fontSize: 18.0,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.bold,
  letterSpacing: 0.5,
);
