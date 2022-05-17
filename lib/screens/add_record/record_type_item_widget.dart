import 'package:expense/screens/add_record/record_type_widget.dart';
import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/theme/app_theme.dart';
import 'package:flutter/material.dart';

class RecordTypeItemWidget extends StatelessWidget {
  final Function() onItemTap;
  final String title;
  final bool isTypeExpense;
  final RecordType recordType;

  const RecordTypeItemWidget({
    required this.onItemTap,
    required this.title,
    required this.isTypeExpense,
    required this.recordType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 300,
        ),
        alignment: Alignment.center,
        height: Dimens.height30,
        width: Dimens.width80,
        decoration: BoxDecoration(
          boxShadow: isTypeExpense ? AppTheme.commonShadow : null,
          border: isTypeExpense
              ? null
              : Border.all(
                  color: AppColors.primaryColor,
                ),
          color: isTypeExpense ? AppColors.primaryColor : AppColors.whiteColor,
          borderRadius: recordType == RecordType.expense
              ? const BorderRadius.horizontal(
                  right: Radius.circular(
                    Dimens.radius10,
                  ),
                )
              : const BorderRadius.horizontal(
                  left: Radius.circular(
                    Dimens.radius10,
                  ),
                ),
        ),
        child: Text(
          title,
        ),
      ),
    );
  }
}
