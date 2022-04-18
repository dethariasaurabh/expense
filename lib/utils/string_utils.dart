import 'package:expense/res/strings/str_en.dart';
import 'package:expense/utils/constants.dart';
import 'package:get/get.dart';

import '../res/strings/str_de.dart';

class StringUtils extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        enUs: stringsEn,
        hiIn: stringsDe,
      };
}
