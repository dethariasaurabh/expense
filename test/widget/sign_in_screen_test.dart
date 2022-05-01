// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:expense/screens/onboarding/login_screen.dart';
import 'package:expense/services/firebase_servcies.dart';
import 'package:expense/theme/app_theme.dart';
import 'package:expense/utils/keys.dart';
import 'package:expense/utils/string_utils.dart';
import 'package:expense/widgets/app_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await FirebaseServices.initFirebase();
  });

  testWidgets('Sign in screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeData,
        translations: StringUtils(),
        locale: const Locale('en', 'US'),
        home: LoginScreen(
          key: loginScreenGlobalKey,
        ),
      ),
    );

    // Verify that header, country code picker and phone number field
    expect(
      find.byKey(loginScreenHeaderKey),
      findsOneWidget,
    );
    expect(
      find.byKey(countryCodePickerKey),
      findsOneWidget,
    );
    expect(
      find.byKey(phoneNumberEditTextKey),
      findsOneWidget,
    );

    final phoneNumberFieldFinder = find.byKey(phoneNumberEditTextKey);
    final phoneNumberInput =
        tester.firstWidget<AppEditText>(phoneNumberFieldFinder);

    phoneNumberInput.textEditingController.text = '1234567890';

    loginScreenGlobalKey.currentState!.validatePhoneNumber(
      phoneNumberInput.textEditingController.text,
    );

    await tester.pump();

    await tester.tap(
      find.byKey(loginButtonKey),
    );

    await tester.pumpAndSettle();
  });
}
