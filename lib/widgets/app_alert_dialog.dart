import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:expense/widgets/app_button.dart';
import 'package:flutter/material.dart';

showAlertDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String buttonText,
  Function()? onTapEvent,
}) {
  showDialog(
      context: context,
      builder: (context) => Center(
            child: AppAlertDialog(
              message: message,
              title: title,
              onTapEvent: onTapEvent,
              buttonText: buttonText,
            ),
          ));
}

class AppAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final Function()? onTapEvent;

  const AppAlertDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onTapEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: AppColors.lightGreyColor,
              blurRadius: Dimens.radius10,
            ),
          ],
          borderRadius: BorderRadius.circular(
            Dimens.radius10,
          ),
          color: AppColors.whiteColor,
        ),
        padding: const EdgeInsets.all(
          Dimens.space24,
        ),
        margin: const EdgeInsets.all(
          Dimens.space24,
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              title,
              style: AppTextStyle.xLargeBlackText,
            ),
            Container(
              height: Dimens.height20,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyle.mediumText,
            ),
            Container(
              height: Dimens.height20,
            ),
            AppButton(
              isEnabled: true,
              buttonText: buttonText,
              buttonTapEvent: () {
                Navigator.of(context).pop();
                onTapEvent?.call();
              },
            )
          ],
        ),
      ),
    );
  }
}
