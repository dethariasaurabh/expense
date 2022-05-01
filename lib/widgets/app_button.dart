import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final bool isEnabled;
  final String buttonText;
  final Function()? buttonTapEvent;
  final FocusNode? focusNode;

  const AppButton({
    Key? key,
    required this.isEnabled,
    required this.buttonText,
    this.buttonTapEvent,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled
          ? () {
              if (focusNode != null) {
                focusNode!.unfocus();
              }
              buttonTapEvent?.call();
            }
          : null,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: Dimens.height50,
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.primaryColor : AppColors.lightGreyColor,
          borderRadius: BorderRadius.circular(
            Dimens.radius10,
          ),
          boxShadow: isEnabled
              ? const [
                  BoxShadow(
                    color: AppColors.primaryColor,
                    blurRadius: Dimens.radius10,
                  ),
                ]
              : const [],
        ),
        child: Center(
          child: Text(
            buttonText,
            style: AppTextStyle.xLargeText.copyWith(
              color: isEnabled ? AppColors.whiteColor : AppColors.subTitleColor,
            ),
          ),
        ),
      ),
    );
  }
}
