import 'package:expense/res/strings/str_keys.dart';
import 'package:expense/screens/add_expense_screen.dart';
import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/utils/animation.dart';
import 'package:expense/utils/keys.dart';
import 'package:expense/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'action_button_item.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({Key? key}) : super(key: key);

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final Rx<bool> _isMenuVisible = false.obs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: Dimens.zero,
      bottom: Dimens.height50,
      child: Row(
        children: [
          CustomAnimation(
            key: animationStateKey,
            child: Row(
              children: [
                ActionButtonItem(
                  onTap: () {
                    switchMenu();
                    navigateTo(
                      const AddExpenseScreen(),
                    );
                  },
                  actionItemTitle: StringKeys.addRecordButton.tr,
                ),
                const SizedBox(
                  width: Dimens.width10,
                ),
                ActionButtonItem(
                  onTap: () {},
                  actionItemTitle: StringKeys.addBudgetButton.tr,
                ),
                const SizedBox(
                  width: Dimens.width20,
                ),
              ],
            ),
            duration: const Duration(
              milliseconds: 500,
            ),
            animationType: AnimationType.slideAnimation,
            offset: Tween<Offset>(
              begin: const Offset(
                1.0,
                0.0,
              ),
              end: Offset.zero,
            ),
          ),
          InkWell(
            highlightColor: AppColors.transparent,
            splashColor: AppColors.transparent,
            onTap: switchMenu,
            child: Container(
              height: Dimens.height50,
              width: Dimens.width50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(
                    Dimens.radius50,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor,
                    blurRadius: Dimens.radius10,
                  ),
                ],
                color: AppColors.primaryColor,
              ),
              child: Center(
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: _controller,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void switchMenu() {
    _isMenuVisible.value = !_isMenuVisible.value;
    if (_isMenuVisible.value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    animationStateKey.currentState!.changeAnimation(_isMenuVisible.value);
  }
}
