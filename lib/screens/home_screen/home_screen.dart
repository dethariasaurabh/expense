import 'package:expense/screens/home_screen/widgets/action_button.dart';
import 'package:expense/screens/onboarding/login_screen.dart';
import 'package:expense/services/firebase_servcies.dart';
import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:expense/utils/ui_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Rx<String> userName = ''.obs;

  @override
  void initState() {
    super.initState();
    User? currentUser = FirebaseServices.getCurrentUser();
    if (currentUser != null) {
      FirebaseServices.getUserData(currentUser.uid).then((value) {
        userName.value = value.get('userName');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.width10,
                    vertical: Dimens.height10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return Text(
                          'Welcome ${userName.value}!',
                          style: AppTextStyle.xLargeBoldText.copyWith(
                            color: AppColors.secondaryTextColor,
                          ),
                        );
                      }),
                      GestureDetector(
                        child: const Icon(
                          CupertinoIcons.power,
                        ),
                        onTap: () {
                          FirebaseServices.auth.signOut().then((value) {
                            navigateTo(
                              const LoginScreen(),
                              clearStack: true,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const ActionButton(),
          ],
        ),
      ),
    );
  }
}
