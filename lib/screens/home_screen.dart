import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Welcome!',
            style: AppTextStyle.mediumText.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
