import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String desc;

  const HeaderWidget({
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.xLargeBoldText,
        ),
        const SizedBox(
          height: Dimens.height20,
        ),
        Text(
          desc,
          style: AppTextStyle.mediumText.copyWith(
            color: AppColors.secondaryTextColor,
          ),
        ),
        const SizedBox(
          height: Dimens.height20,
        ),
      ],
    );
  }
}
