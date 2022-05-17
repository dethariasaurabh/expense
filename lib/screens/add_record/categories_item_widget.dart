import 'package:expense/model/categories_model.dart';
import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:expense/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CategoriesItemWidget extends StatelessWidget {
  final CategoryModel categoryModel;
  final Function() onTapItem;

  const CategoriesItemWidget({
    required this.categoryModel,
    required this.onTapItem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapItem,
      child: Container(
        decoration: BoxDecoration(
          color: categoryModel.isSelected
              ? AppColors.primaryColor
              : AppColors.lightGreyColor,
          borderRadius: BorderRadius.circular(
            Dimens.radius50,
          ),
          boxShadow: categoryModel.isSelected ? AppTheme.commonShadow : null,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: Dimens.height8,
          horizontal: Dimens.width20,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: Dimens.height5,
          horizontal: Dimens.width5,
        ),
        child: Text(
          categoryModel.emoji + ' ' + categoryModel.category,
          style: AppTextStyle.mediumText.copyWith(
            color: categoryModel.isSelected
                ? AppColors.whiteColor
                : AppColors.darkTitleColor,
          ),
        ),
      ),
    );
  }
}
