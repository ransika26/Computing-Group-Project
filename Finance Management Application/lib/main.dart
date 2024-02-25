import 'package:finanace_management_application/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:finanace_management_application/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:finanace_management_application/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }
}


