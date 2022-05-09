import 'package:expense/model/categories_model.dart';
import 'package:expense/res/strings/str_keys.dart';
import 'package:expense/screens/add_record/categories_widget.dart';
import 'package:expense/screens/add_record/record_type_widget.dart';
import 'package:expense/services/firebase_servcies.dart';
import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:expense/theme/app_theme.dart';
import 'package:expense/utils/constants.dart';
import 'package:expense/utils/keys.dart';
import 'package:expense/widgets/app_alert_dialog.dart';
import 'package:expense/widgets/app_button.dart';
import 'package:expense/widgets/app_edit_text.dart';
import 'package:expense/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  // final SpeechToText _speechToText = SpeechToText();
  final String text = 'Press the button and start speaking';

  final bool isListening = false;

  final TextEditingController amountTextEditingController =
      TextEditingController();

  final TextEditingController recordTitleTextEditingController =
      TextEditingController();

  final FocusNode amountFieldNode = FocusNode();

  final FocusNode recordTitleFieldNode = FocusNode();

  final Rx<DateTime> selectedDate = DateTime.now().obs;

  final Rx<String> amountErrorText = ''.obs;

  final Rx<String> titleErrorText = ''.obs;

  final Rx<String> categoryErrorText = ''.obs;

  final Rx<bool> isError = true.obs;

  late Rx<CategoryModel> selectedCategory;

  final Rx<RecordType> recordType = RecordType.income.obs;

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      amountFieldNode.unfocus();
      recordTitleFieldNode.unfocus();
    });

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(StringKeys.addRecordTitle.tr),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimens.height20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.space24,
                    ),
                    child: RecordTypeWidget(
                      callBack: (RecordType _recordType) {
                        recordType.value = _recordType;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.height30,
                  ),
                  SizedBox(
                    height: Dimens.height80,
                    child: Obx(() {
                      return DatePicker(
                          backgroundColor: AppColors.whiteShade200,
                          selectedColor: AppColors.primaryColor,
                          textColor: AppColors.subTitleColor,
                          selectedTextColor: AppColors.whiteColor,
                          selectedItemShadow: AppTheme.commonShadow,
                          key: datePickerWidgetStateKey,
                          selectedDate: selectedDate.value,
                          startDate: DateTime.now(),
                          onDateChanged: (DateTime date) {
                            selectedDate.value = date;
                          });
                    }),
                  ),
                  const SizedBox(
                    height: Dimens.height20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.space24,
                    ),
                    child: AppEditText(
                      hintText: StringKeys.recordTitleField.tr,
                      textEditingController: recordTitleTextEditingController,
                      focusNode: recordTitleFieldNode,
                      textStyle: AppTextStyle.mediumText,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.name,
                      onTextChange: (title) => validateData(
                        textEditingController: recordTitleTextEditingController,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.height10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.space24,
                    ),
                    child: Obx(
                      () => AppEditText(
                        hintText: StringKeys.amountField.tr,
                        textEditingController: amountTextEditingController,
                        focusNode: amountFieldNode,
                        textStyle: AppTextStyle.mediumText,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                        maxLength: 10,
                        errorText: amountErrorText.value,
                        onTextChange: (amount) => validateData(
                          textEditingController: amountTextEditingController,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.height10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.width10,
                    ),
                    child: CategoriesWidget(
                      callback: (CategoryModel categoryModel) {
                        selectedCategory = categoryModel.obs;
                        validateData(
                          textEditingController: null,
                        );
                      },
                    ),
                  ),
                  if (categoryErrorText.value.isNotEmpty)
                    Text(
                      categoryErrorText.value,
                      style: AppTextStyle.mediumText.copyWith(
                        color: AppColors.errorTextColor,
                      ),
                    ),
                  const SizedBox(
                    height: Dimens.height100,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.space24,
                vertical: Dimens.width20,
              ),
              color: AppColors.whiteColor,
              child: Obx(
                () => AppButton(
                  isEnabled: !isError.value,
                  buttonText: StringKeys.addButton.tr,
                  buttonTapEvent: () async {
                    String userUid = FirebaseServices.getCurrentUser()!.uid;

                    Map<String, dynamic> recordData = {
                      recordTypeField: recordType.toString(),
                      recordDateField: selectedDate.value.toUtc().toIso8601String(),
                      recordTitleField: recordTitleTextEditingController.text,
                      recordAmountField: amountTextEditingController.text,
                      recordCategoryField: selectedCategory.value.toJson(),
                    };

                    await FirebaseServices.setRecordData(
                      userUid: userUid,
                      recordData: recordData,
                    );

                    showAlertDialog(
                      context: context,
                      title: StringKeys.successTitle.tr,
                      message: StringKeys.recordAddedSuccessMessage.tr,
                      buttonText: StringKeys.okButton.tr,
                      onTapEvent: () => Get.back(),
                    );
                  },
                ),
              ),
            ),
            // Expanded(
            //   child: Center(
            //     child: Text(
            //       text,
            //     ),
            //   ),
            // ),
            // Expanded(
            //   child: Center(
            //     child: InkWell(
            //       splashColor: null,
            //       focusColor: null,
            //       onTap: toggleRecording,
            //       child: Container(
            //         height: Dimens.height50,
            //         width: Dimens.width50,
            //         decoration: const BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: AppColors.darkColor,
            //         ),
            //         child: Icon(
            //           _speechToText.isNotListening
            //               ? CupertinoIcons.mic_off
            //               : CupertinoIcons.mic,
            //           color: AppColors.whiteColor,
            //           size: Dimens.icon24,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void validateData({
    required TextEditingController? textEditingController,
  }) {
    if (textEditingController == null) {
      categoryErrorText.value = StringKeys.emptyRecordCategoryButton.tr;
    } else if (textEditingController == recordTitleTextEditingController &&
        recordTitleTextEditingController.text.isEmpty) {
      titleErrorText.value = StringKeys.emptyRecordTitleButton.tr;
    } else if (textEditingController == amountTextEditingController &&
        amountTextEditingController.text.isEmpty) {
      amountErrorText.value = StringKeys.emptyRecordAmountButton.tr;
    } else {
      amountErrorText.value = '';
      categoryErrorText.value = '';
      titleErrorText.value = '';
    }

    isError.value = amountTextEditingController.text.isEmpty ||
        recordTitleTextEditingController.text.isEmpty;
  }
}
