import 'package:expense/screens/splash_screen.dart';
import 'package:expense/theme/app_theme.dart';
import 'package:expense/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeData,
      translations: StringUtils(),
      locale: const Locale('en', 'US'),
      home: const SplashScreen(),
    );
  }
}
