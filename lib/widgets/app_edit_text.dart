import 'package:expense/res/strings/str_keys.dart';
import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class AppEditText extends StatefulWidget {

  final String hintText;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final TextStyle textStyle;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final ValueChanged<String>? onTextChange;

  const AppEditText({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    required this.focusNode,
    required this.textStyle,
    required this.textInputAction,
    required this.textInputType,
    required this.onTextChange,
  }) : super(key: key);

  @override
  _AppEditTextState createState() => _AppEditTextState();
}

class _AppEditTextState extends State<AppEditText> {
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      focusNode: widget.focusNode,
      controller: widget.textEditingController,
      style: widget.textStyle,
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      keyboardAppearance: Brightness.light,
      onChanged: widget.onTextChange,
      decoration: InputDecoration(
        hintText: StringKeys.phoneNumberHint.tr,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            Dimens.radius10,
          ),
          borderSide: const BorderSide(
            color: AppColors.secondaryTextColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            Dimens.radius10,
          ),
          borderSide: const BorderSide(
            color: AppColors.subTitleColor,
          ),
        ),
      ),
    );
  }
}
