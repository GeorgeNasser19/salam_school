import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  const TextCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    return Column(
      children: [
        Text(
          "Synod of the Nile",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.red,
              fontSize: isSmallScreen ? 10 : 25,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "Akhmim educational administration",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: isSmallScreen ? 10 : 25,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "El Salam Language Schools",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.red,
              fontSize: isSmallScreen ? 10 : 25,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "Al Kawthar district-Sohage",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: isSmallScreen ? 10 : 25,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
