import 'package:flutter/material.dart';

class TextfieldCustom extends StatelessWidget {
  const TextfieldCustom({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      style: const TextStyle(color: Colors.black),
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white70,
        labelText: 'Enter Student ID',
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
