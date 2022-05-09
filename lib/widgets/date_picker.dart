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
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final List<BoxShadow>? selectedItemShadow;

  const DatePicker({
    Key? key,
    required this.selectedDate,
    required this.startDate,
    this.onDateChanged,
    this.backgroundColor = const Color(0xFFE5E5E5),
    this.selectedColor = const Color(0xFF55C5B8),
    this.textColor = const Color(0xFFAEAEAE),
    this.selectedTextColor = const Color(0xFF39645F),
    this.selectedItemShadow,
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
          DateTime currentTime = DateTime.now();
          DateTime _date = _startDate!.value.add(Duration(days: index));
          date = DateTime(
            _date.year,
            _date.month,
            _date.day,
            currentTime.hour,
            currentTime.minute,
            currentTime.second,
          );

          bool isSelectedDate = widget.selectedDate.day == date.day &&
              widget.selectedDate.month == date.month &&
              widget.selectedDate.year == date.year;

          return GestureDetector(
            key: ValueKey('date_picker_item_$index'),
            onTap: () {
              if (widget.onDateChanged != null) {
                widget.onDateChanged!(date);
              }
              selectedDate!.value = date;
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
                    ? widget.selectedColor
                    : widget.backgroundColor,
                boxShadow: isSelectedDate ? widget.selectedItemShadow : null,
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
                            ? widget.selectedTextColor
                            : widget.textColor),
                  ),
                  Text(
                    DateFormat.MMM().format(date),
                    style: AppTextStyle.mediumText.copyWith(
                        color: isSelectedDate
                            ? widget.selectedTextColor
                            : widget.textColor),
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
