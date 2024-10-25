import 'package:flutter/widgets.dart';

class AppGradients {
  static const primaryGradient = LinearGradient(
      colors: [
        Color(0xFF6F5BFF),
        Color(0xFF539BF5),
        Color(0xFF41DED1),
        Color(0xFF40E0D0),
        Color(0xFF41DED1),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        0.0,
        0.6512,
        0.9998,
        0.9999,
        1.0,
      ]);

  static const secondaryGradient = LinearGradient(
      colors: [
        Color(0xFF5D47FF),
        Color(0xFF7980FF),
        Color(0xFF84A6FF),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        0.0,
        0.4896,
        1.0,
      ]);
}
