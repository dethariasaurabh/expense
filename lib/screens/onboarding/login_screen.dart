import 'package:country_code_picker/country_code_picker.dart';
import 'package:expense/res/strings/str_keys.dart';
import 'package:expense/screens/onboarding/widgets/header.dart';
import 'package:expense/services/firebase_servcies.dart';
import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:expense/theme/app_theme.dart';
import 'package:expense/utils/keys.dart';
import 'package:expense/utils/ui_utils.dart';
import 'package:expense/widgets/app_button.dart';
import 'package:expense/widgets/app_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

GlobalKey<_LoginScreenState> loginScreenGlobalKey =
    GlobalKey<_LoginScreenState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();

  final FocusNode phoneNumberFieldFocusNode = FocusNode();

  final Rx<String> _countryCode = '+1'.obs;
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
                key: loginScreenHeaderKey,
                title: StringKeys.signInTitle.tr,
                desc: StringKeys.signInBody.tr,
              ),
              phoneNumberInputWidget(),
              const Spacer(),
              Obx(
                () => AppButton(
                  key: loginButtonKey,
                  isEnabled: _isEdited.value && _errorText.value.isEmpty,
                  focusNode: phoneNumberFieldFocusNode,
                  buttonText: StringKeys.signInButton.tr,
                  buttonTapEvent: () {
                    FirebaseServices().signInWithPhoneNumber(
                      buildContext: context,
                      phoneNumber: _countryCode + _phoneNumberController.text,
                    );
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

  Widget phoneNumberInputWidget() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Dimens.radius10,
            ),
            boxShadow: AppTheme.whiteShadow,
            color: AppColors.whiteColor,
          ),
          child: CountryCodePicker(
            key: countryCodePickerKey,
            showFlag: false,
            initialSelection: 'US',
            showFlagDialog: true,
            dialogSize: Size(
                getScreenWidth(context) - 50, getScreenHeight(context) - 100),
            onChanged: (countryCode) {
              _countryCode.value = countryCode.dialCode!;
            },
          ),
        ),
        const SizedBox(
          width: Dimens.width10,
        ),
        Expanded(
          child: Obx(
            () {
              return AppEditText(
                key: phoneNumberEditTextKey,
                hintText: StringKeys.confirmationCodeHint.tr,
                focusNode: phoneNumberFieldFocusNode,
                textEditingController: _phoneNumberController,
                textStyle: AppTextStyle.mediumText,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.number,
                onTextChange: (phoneNumber) => validatePhoneNumber(phoneNumber),
                errorText: _errorText.value,
              );
            },
          ),
        ),
      ],
    );
  }

  bool validatePhoneNumber(String phoneNumber) {
    _isEdited.value = true;
    if (phoneNumber.isEmpty) {
      _errorText.value = 'Please enter the phone number';
      return false;
    } else if (!phoneNumber.isNumericOnly || !phoneNumber.isPhoneNumber) {
      _errorText.value = 'Please enter valid phone number';
      return false;
    } else {
      _errorText.value = '';
      return true;
    }
  }
}
