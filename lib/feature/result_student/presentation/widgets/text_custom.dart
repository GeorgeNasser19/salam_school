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
              color: const Color.fromARGB(255, 247, 16, 0),
              fontSize: isSmallScreen ? 12.5 : 32,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "Akhmim educational administration",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: isSmallScreen ? 12.5 : 32,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "El Salam Language Schools",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: const Color.fromARGB(255, 255, 17, 0),
              fontSize: isSmallScreen ? 12.5 : 32,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "Al Kawthar district-Sohag",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: isSmallScreen ? 12.5 : 32,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
