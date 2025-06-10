// logo.dart
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double height;

  const AppLogo({super.key, this.height = 40});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
      child: Image.asset(
        'assets/logo.png',
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}