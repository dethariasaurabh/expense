// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:expense/screens/home_screen.dart';
import 'package:expense/screens/onboarding/login_screen.dart';
import 'package:expense/screens/splash_screen.dart';
import 'package:expense/services/firebase_servcies.dart';
import 'package:expense/theme/app_theme.dart';
import 'package:expense/utils/keys.dart';
import 'package:expense/utils/string_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await FirebaseServices.initFirebase();
  });

  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeData,
        translations: StringUtils(),
        locale: const Locale('en', 'US'),
        home: const SplashScreen(),
      ),
    );

    // Verify that app logo and app name
    expect(
      find.byKey(mainLogoKey),
      findsOneWidget,
    );
    expect(
      find.byKey(appNameKey),
      findsOneWidget,
    );

    await tester.pump(
      const Duration(
        seconds: 2,
      ),
    );
    User? currentUser = FirebaseServices.getCurrentUser();
    if (currentUser == null || currentUser.uid.isEmpty) {
      Get.to(
        const LoginScreen(),
      );
      await tester.pump();
      expect(
        find.byKey(loginScreenKey),
        findsOneWidget,
      );
    } else {
      Get.to(
        const HomeScreen(),
      );
      await tester.pump();
      expect(
        find.byKey(homeScreenKey),
        findsOneWidget,
      );
    }
  });
}
