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

final greenFont = TextStyle(
  color: primaryGreenColor,
  fontSize: 15.0,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
);

final greenBoldFont = TextStyle(
  color: primaryGreenColor,
  fontSize: 15.0,
  fontFamily: 'Roboto bold',
  letterSpacing: 0.5,
);
