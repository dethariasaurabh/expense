import 'package:expense/res/images/images.dart';
import 'package:expense/res/strings/str_keys.dart';
import 'package:expense/screens/home_screen.dart';
import 'package:expense/screens/onboarding/login_screen.dart';
import 'package:expense/services/firebase_servcies.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      User? currentUser = FirebaseServices.getCurrentUser();
      Get.to(() => currentUser == null || currentUser.uid.isEmpty
          ? const LoginScreen()
          : const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: 488,
            height: 291.0,
            child: Image.asset(
              Images.splashBg,
              opacity: const AlwaysStoppedAnimation(
                0.5,
              ),
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SvgPicture.asset(
                  Images.mainLogo,
                  width: 100.0,
                  height: 100.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  StringKeys.appTitle.tr,
                  style: AppTextStyle.xxLargeBlackText.copyWith(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
