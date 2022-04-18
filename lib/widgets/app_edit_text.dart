import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AppEditText extends StatefulWidget {
  final String hintText;
  final String? errorText;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final TextStyle textStyle;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final ValueChanged<String>? onTextChange;
  final int? maxLength;

  const AppEditText({
    Key? key,
    required this.hintText,
    this.errorText,
    required this.textEditingController,
    required this.focusNode,
    required this.textStyle,
    required this.textInputAction,
    required this.textInputType,
    this.onTextChange,
    this.maxLength,
  }) : super(key: key);

  @override
  _AppEditTextState createState() => _AppEditTextState();
}

class _AppEditTextState extends State<AppEditText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: widget.focusNode,
          controller: widget.textEditingController,
          style: widget.textStyle,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          keyboardAppearance: Brightness.light,
          onChanged: widget.onTextChange,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            hintText: widget.hintText,
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
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty)
          Text(
            widget.errorText!,
            style: AppTextStyle.mediumText.copyWith(
              color: AppColors.errorTextColor,
            ),
          )
      ],
    );
  }
}
