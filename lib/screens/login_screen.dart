import 'package:country_code_picker/country_code_picker.dart';
import 'package:expense/res/strings/str_keys.dart';
import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:expense/utils/ui_utils.dart';
import 'package:expense/widgets/app_button.dart';
import 'package:expense/widgets/app_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
              Text(
                StringKeys.signInTitle.tr,
                style: AppTextStyle.xLargeBoldText,
              ),
              const SizedBox(
                height: Dimens.height20,
              ),
              Text(
                StringKeys.signInBody.tr,
                style: AppTextStyle.mediumText.copyWith(
                  color: AppColors.secondaryTextColor,
                ),
              ),
              const SizedBox(
                height: Dimens.height20,
              ),
              Row(
                children: [
                   Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(
                         Dimens.radius10,
                       ),
                       border: Border.all(
                         color: AppColors.subTitleColor,
                       ),
                     ),
                     child: CountryCodePicker(
                       showFlag: false,
                       initialSelection: 'US',
                       showFlagDialog: true,
                       dialogSize: Size(
                         getScreenWidth(context) - 50,
                         getScreenHeight(context) - 100
                       ),
                      onChanged: (countryCode) {
                          _countryCode.value = countryCode.dialCode!;
                       },
                      ),
                   ),
                  const SizedBox(
                    width: Dimens.width10,
                  ),
                  Expanded(
                    child: AppEditText(
                      hintText: StringKeys.phoneNumberHint.tr,
                      focusNode: phoneNumberFieldFocusNode,
                      textEditingController: _phoneNumberController,
                      textStyle: AppTextStyle.mediumText,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.number,
                      onTextChange: (phoneNumber) => validatePhoneNumber(phoneNumber),
                    ),
                  ),
                ],
              ),
              Obx(() => Text(
                _errorText.value,
                style: AppTextStyle.mediumText.copyWith(
                  color: AppColors.errorTextColor,
                ),
              ),),
              const Spacer(),
              Obx(
                () => AppButton(
                  isEnabled: _errorText.value.isEmpty,
                  focusNode: phoneNumberFieldFocusNode,
                  buttonText: StringKeys.signInButton.tr,
                  buttonTapEvent: () {
                    print('Tapped here: $_countryCode ${_phoneNumberController.text}');
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

  bool validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      _errorText.value = 'Please enter the phone number';
      return false;
    } else if (!phoneNumber.isNumericOnly ||
        !phoneNumber.isPhoneNumber) {
      _errorText.value = 'Please enter valid phone number';
      return false;
    } else {
      _errorText.value = '';
      return true;
    }
  }

}
