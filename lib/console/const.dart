import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

extension MediaQuerySize on BuildContext {
  Size getSize() => MediaQuery.of(this).size;
}

extension PercentSized on num {
  double get hp => (Get.height * (this / 100));
  double get wp => (Get.width * (this / 100));
  double get sp => Get.width / 100 * (this / 3);
}

extension ResponsiveText on num {
  double get px => Get.width / 100 * (this / 3);
}
