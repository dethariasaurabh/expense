import 'package:expense/screens/add_record/record_type_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum RecordType {
  income,
  expense,
}

class RecordTypeWidget extends StatelessWidget {
  RecordTypeWidget({
    required this.callBack,
    Key? key,
  }) : super(key: key);

  final Rx<bool> recordTypeExpense = false.obs;
  final Function(RecordType recordType) callBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => RecordTypeItemWidget(
            onItemTap: () {
              callBack(RecordType.income);
              return recordTypeExpense.value = false;
            },
            title: 'Income',
            isTypeExpense: !recordTypeExpense.value,
            recordType: RecordType.income,
          ),
        ),
        Obx(
          () => RecordTypeItemWidget(
            onItemTap: () {
              callBack(RecordType.expense);
              return recordTypeExpense.value = true;
            },
            title: 'Expense',
            isTypeExpense: recordTypeExpense.value,
            recordType: RecordType.expense,
          ),
        ),
      ],
    );
  }
}
