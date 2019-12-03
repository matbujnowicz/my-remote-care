import 'package:flutter/material.dart';

class CardDefault extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;

  CardDefault({this.child, this.margin});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(15),
      margin: margin,
      width: screenWidth * 0.9,
      child: child,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
