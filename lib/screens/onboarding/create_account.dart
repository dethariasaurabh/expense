import 'package:expense/model/user_model.dart';
import 'package:expense/res/strings/str_keys.dart';
import 'package:expense/screens/home_screen.dart';
import 'package:expense/screens/onboarding/widgets/header.dart';
import 'package:expense/services/firebase_servcies.dart';
import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:expense/utils/constants.dart';
import 'package:expense/utils/ui_utils.dart';
import 'package:expense/widgets/app_button.dart';
import 'package:expense/widgets/app_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccount extends StatefulWidget {
  final UserModel userObj;

  const CreateAccount({
    Key? key,
    required this.userObj,
  }) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _fullNameController = TextEditingController();

  final FocusNode fullNameFieldFocusNode = FocusNode();

  final Rx<String> _errorText = ''.obs;
  final Rx<bool> _isEdited = false.obs;
  final Rx<bool> _isTNCAccepted = false.obs;

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
              HeaderWidget(
                title: StringKeys.createAccountTitle.tr,
                desc: StringKeys.createAccountBody.tr,
              ),
              Obx(
                () {
                  return AppEditText(
                    hintText: StringKeys.fullNameHint.tr,
                    focusNode: fullNameFieldFocusNode,
                    textEditingController: _fullNameController,
                    textStyle: AppTextStyle.mediumText,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.name,
                    onTextChange: (userName) => validateUsername(userName),
                    errorText: _errorText.value,
                  );
                },
              ),
              const Spacer(),
              tncWidget(),
              const SizedBox(
                height: Dimens.height20,
              ),
              Obx(
                () => AppButton(
                  isEnabled: _isEdited.value &&
                      _errorText.value.isEmpty &&
                      _isTNCAccepted.value,
                  focusNode: fullNameFieldFocusNode,
                  buttonText: StringKeys.createAccountButton.tr,
                  buttonTapEvent: () {
                    widget.userObj.userName = _fullNameController.text;
                    FirebaseServices.setUserData(
                      userUid: widget.userObj.userUid,
                      appUser: widget.userObj.toJson(),
                    ).then(
                      (value) => navigateTo(
                        const HomeScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tncWidget() {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: _isTNCAccepted.value,
            onChanged: (accepted) {
              _isTNCAccepted.value = accepted ?? false;
            },
          ),
        ),
        const SizedBox(
          width: Dimens.width10,
        ),
        Expanded(
          child: Text(
            StringKeys.tncAccepted.tr,
            maxLines: 2,
            style: AppTextStyle.mediumText.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),
        ),
      ],
    );
  }

  void validateUsername(String userName) {
    _isEdited.value = true;
    ErrorType errorType = isValidUserName(userName: userName);
    if (errorType == ErrorType.emptyFieldError) {
      _errorText.value = StringKeys.emptyUserNameError.tr;
    } else if (errorType == ErrorType.invalidFieldError) {
      _errorText.value = StringKeys.invalidUserNameError.tr;
    } else {
      _errorText.value = '';
    }
  }
}
