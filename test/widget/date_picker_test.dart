import 'package:expense/theme/app_theme.dart';
import 'package:expense/utils/keys.dart';
import 'package:expense/utils/string_utils.dart';
import 'package:expense/widgets/date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void main() {
  testWidgets('Date picker smock test', (WidgetTester tester) async {
    // Set the start date and selected date
    DateTime selectedDate = DateTime.now();
    DateTime startDate = selectedDate.subtract(
      const Duration(
        days: 9,
      ),
    );

    DatePicker datePicker = DatePicker(
      key: datePickerWidgetStateKey,
      startDate: startDate,
      selectedDate: selectedDate,
      onDateChanged: (DateTime newDate) {
        selectedDate = newDate;
      },
    );

    // Build app and trigger a frame.
    await tester.pumpWidget(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeData,
      translations: StringUtils(),
      locale: const Locale('en', 'US'),
      home: datePicker,
    ));

    // Scroll until the item to be found appears.
    await tester.drag(find.byType(ListView), const Offset(-300.0, 50));
    await tester.pump();
    await tester.pump(
      const Duration(seconds: 2),
    );
    await tester.drag(find.byType(ListView), const Offset(-500.0, 50));
    await tester.pump();
    await tester.pump(
      const Duration(seconds: 2),
    );
    await tester.drag(find.byType(ListView), const Offset(-700.0, 50));
    await tester.pump();
    await tester.pump(
      const Duration(seconds: 2),
    );

    // Verify that the item is available in the list
    expect(
      find.byKey(
        const ValueKey('date_picker_item_22'),
      ),
      findsOneWidget,
    );

    // Tap on the item
    await tester.tap(
      find.byKey(
        const ValueKey('date_picker_item_22'),
      ),
    );

    await tester.pump();

    // Define the expected date
    DateTime expectedDate = startDate.add(
      const Duration(days: 22),
    );

    // Verify the selected date and the expected date are matching.
    expect(
      DateFormat.yMd().format(selectedDate),
      DateFormat.yMd().format(expectedDate),
    );
  });
}
