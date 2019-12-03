import 'package:flutter/material.dart';
import 'package:mrc/app/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Remote Care',
      theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Color.fromARGB(255, 231, 66, 146)),
      routes: routes,
    );
  }
}
