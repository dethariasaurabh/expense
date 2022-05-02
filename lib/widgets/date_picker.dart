import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:expense/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final DateTime selectedDate;
  final DateTime startDate;
  final Function(DateTime)? onDateChanged;

  const DatePicker({
    Key? key,
    required this.selectedDate,
    required this.startDate,
    this.onDateChanged,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  final Rx<int> length = 20.obs;
  Rx<DateTime>? _startDate;
  Rx<DateTime>? selectedDate;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startDate = widget.startDate.obs;
    selectedDate = widget.selectedDate.obs;
    int difference = widget.startDate.difference(widget.selectedDate).inDays;
    if (difference > 20) {
      length.value = difference;
    }
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          _startDate!.value = _startDate!.value.subtract(
            const Duration(
              days: 10,
            ),
          );
          length.value += 10;
        } else {
          length.value += 10;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        key: datePickerWidgetListKey,
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: length.value,
        shrinkWrap: true,
        itemBuilder: (listContext, index) {
          // get the date object based on the index position
          DateTime date;
          DateTime _date = _startDate!.value.add(Duration(days: index));
          date = DateTime(_date.year, _date.month, _date.day);

          bool isSelectedDate = widget.selectedDate.day == date.day &&
              widget.selectedDate.month == date.month &&
              widget.selectedDate.year == date.year;

          return GestureDetector(
            key: ValueKey('date_picker_item_$index'),
            onTap: () {
              if (widget.onDateChanged != null) {
                widget.onDateChanged!(date);
              } else {
                selectedDate!.value = date;
              }
            },
            child: Container(
              constraints: const BoxConstraints(
                minHeight: Dimens.height50,
                minWidth: Dimens.width50,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimens.radius10,
                ),
                color: isSelectedDate
                    ? AppColors.primaryColor
                    : AppColors.lightGreyColor,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.width5,
                vertical: Dimens.width10,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: Dimens.width5,
              ),
              child: Wrap(
                direction: Axis.vertical,
                children: [
                  Text(
                    date.day.toString(),
                    style: AppTextStyle.xLargeBoldText.copyWith(
                        color: isSelectedDate
                            ? AppColors.whiteColor
                            : AppColors.darkTitleColor),
                  ),
                  Text(
                    DateFormat.MMM().format(date),
                    style: AppTextStyle.mediumText.copyWith(
                        color: isSelectedDate
                            ? AppColors.whiteColor
                            : AppColors.darkTitleColor),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
