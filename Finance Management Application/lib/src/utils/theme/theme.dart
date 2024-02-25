import 'package:flutter/material.dart';
import 'package:finanace_management_application/src/utils/theme/widget_themes/text_theme.dart';
import 'package:finanace_management_application/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:finanace_management_application/src/utils/theme/widget_themes/elevated_button_theme.dart';


class AppTheme{
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.yellow,
    brightness: Brightness.light,
    textTheme: TextThemes.lightTextTheme,
    appBarTheme: AppBarTheme(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
    //outlinedButtonTheme: OutlinedButtonTheme.lightOutlinedButtonTheme,
    //elevatedButtonTheme: ElevatedButtonTheme.lightElevatedButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.yellow,
    brightness: Brightness.dark,
    textTheme: TextThemes.darkTextTheme,
    appBarTheme: AppBarTheme(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
    //outlinedButtonTheme: OutlinedButtonTheme.darkOutlinedButtonTheme,
    //elevatedButtonTheme: ElevatedButtonTheme.darkOutlinedButtonTheme,
  );
}

