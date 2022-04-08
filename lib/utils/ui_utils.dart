import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

/// Use this method to call a function after build() method is completed.
void onWidgetBuildDone(Function function) {
  SchedulerBinding.instance!.addPostFrameCallback((_) {
    function();
  });
}

/// Retrieve the device screen size.
Size getScreenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

/// Retrieve the device screen width.
double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// Retrieve the device screen height.
double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// Navigate function
Future navigateTo(Widget screen,
    {Transition? transition,
      bool clearStack = false,
      bool offCurrentScreen = false,
      bool preventDuplicates = false,
      Duration? duration,
      bool popGesture = true}) async {
  final t = transition ?? Transition.rightToLeftWithFade;
  final d = duration ?? const Duration(milliseconds: 250);
  if (clearStack) {
    return Get.offAll(() => screen, transition: t, duration: d);
  } else if (offCurrentScreen) {
    return Get.off(() => screen,
        transition: t,
        duration: d,
        preventDuplicates: preventDuplicates,
        popGesture: popGesture);
  } else {
    return Get.to(() => screen,
        transition: t,
        duration: d,
        preventDuplicates: preventDuplicates,
        popGesture: popGesture);
  }
}