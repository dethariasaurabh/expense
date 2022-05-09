import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense/model/user_model.dart';
import 'package:expense/res/strings/str_keys.dart';
import 'package:expense/screens/home_screen/home_screen.dart';
import 'package:expense/screens/onboarding/create_account.dart';
import 'package:expense/screens/onboarding/widgets/header.dart';
import 'package:expense/services/firebase_servcies.dart';
import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:expense/utils/ui_utils.dart';
import 'package:expense/widgets/app_button.dart';
import 'package:expense/widgets/app_edit_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodeVerificationScreen extends StatefulWidget {
  final FirebaseAuth firebaseAuth;
  final String phoneNumber;
  final String verificationId;

  const CodeVerificationScreen({
    Key? key,
    required this.firebaseAuth,
    required this.phoneNumber,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<CodeVerificationScreen> createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  final TextEditingController _confirmationCodeController =
      TextEditingController();

  final FocusNode verificationCodeFieldFocusNode = FocusNode();

  final Rx<String> _errorText = ''.obs;
  final Rx<bool> _isEdited = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        bottom: true,
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(
            Dimens.space24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                title: StringKeys.confirmationCodeTitle.tr,
                desc: StringKeys.confirmationCodeBody.tr,
              ),
              Obx(
                () => AppEditText(
                  hintText: StringKeys.confirmationCodeBody.tr,
                  focusNode: verificationCodeFieldFocusNode,
                  textEditingController: _confirmationCodeController,
                  textStyle: AppTextStyle.mediumText,
                  maxLength: 6,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                  errorText: _errorText.value,
                  onTextChange: (confirmationCode) =>
                      validateConfirmationCode(confirmationCode),
                ),
              ),
              const Spacer(),
              Obx(
                () => AppButton(
                  isEnabled: _isEdited.value && _errorText.value.isEmpty,
                  focusNode: verificationCodeFieldFocusNode,
                  buttonText: StringKeys.signInButton.tr,
                  buttonTapEvent: () {
                    String confirmationCode = _confirmationCodeController.text;
                    verifyUser(confirmationCode);
                  },
                ),
              ),
              const SizedBox(
                height: Dimens.height20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateConfirmationCode(String confirmationCode) {
    _isEdited.value = true;
    if (confirmationCode.isEmpty) {
      _errorText.value = 'Please enter confirmation code.';
      return false;
    } else if (confirmationCode.length != 6) {
      _errorText.value = 'Please enter valid confirmation code.';
      return false;
    } else {
      _errorText.value = '';
      return true;
    }
  }

  Future<void> verifyUser(String confirmationCode) async {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: confirmationCode,
    );

    // Sign the user in (or link) with the credential
    UserCredential userCredential =
        await widget.firebaseAuth.signInWithCredential(credential);

    final User? user = userCredential.user;

    if (user != null) {
      // Check if the user is registered or not
      final DocumentSnapshot userData =
          await FirebaseServices.getUserData(user.uid);

      if (!userData.exists) {
        UserModel userObj = UserModel(
          userUid: user.uid,
          phoneNumber: user.phoneNumber ?? '',
          userName: user.displayName ?? '',
        );

        navigateTo(
          CreateAccount(
            userObj: userObj,
          ),
          clearStack: true,
        );
      } else {
        navigateTo(
          const HomeScreen(),
          clearStack: true,
        );
      }
    }
  }
}
