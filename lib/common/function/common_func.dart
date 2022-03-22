import 'package:flutter/material.dart';

// ダークモード判定
bool isDarkMode(BuildContext context) {
  final Brightness brightness = MediaQuery.platformBrightnessOf(context);
  return brightness == Brightness.dark;
}
