import 'package:flutter/material.dart';
import 'package:loginuicolors/colors/colors.dart';

class AppTheme {
  static final colors = AppColors();
  const AppTheme._();
  static ThemeData define() {
    return ThemeData(
      primaryColor: Color(0xFFBF4342),
      secondaryHeaderColor: Color(0xFF8C1C13),
      focusColor: Color(0xFFA78A7F),
    );
  }
}
