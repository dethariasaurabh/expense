import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:expense/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ActionButtonItem extends StatelessWidget {
  final Function() onTap;
  final String actionItemTitle;

  const ActionButtonItem({
    required this.onTap,
    required this.actionItemTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).splashColor,
      highlightColor: Theme.of(context).highlightColor,
      onTap: onTap,
      child: Container(
        height: Dimens.height50,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.width20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimens.radius50,
          ),
          boxShadow: AppTheme.whiteShadow,
          color: AppColors.whiteColor,
        ),
        child: Text(
          actionItemTitle,
          style: AppTextStyle.mediumText.copyWith(
            color: AppColors.secondaryTextColor,
          ),
        ),
      ),
    );
  }
}
