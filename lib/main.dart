import 'package:flutter/material.dart';
import 'package:learnova/conest/colors.dart';
import 'package:learnova/view/login/test/testing_format.dart';
import 'package:learnova/view/login/test/testmap.dart';
import 'package:learnova/view/login/auth/forgotpass.dart';
import 'package:learnova/view/login/auth/login.dart';
import 'package:learnova/view/login/Welcoming%20Screen/welcoming.dart';
void main() {
  runApp(const MyApp());
}
ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: ColorManager.primary,
    scaffoldBackgroundColor: ColorManager.background,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 16, color: ColorManager.darkGrey),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorManager.lightGrey, width: 0.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TestingFormat(),
    );
  }
}


