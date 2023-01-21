import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/app_layout.dart';
import '../../../../util/app_string.dart';
import '../../../../util/app_style.dart';
import '../controller/attendance_controller.dart';

Widget balancelayout() {
  Duration timerTime = Get.find<AttendanceController>().countdown.value;
  String twoDigits(int num) => num.toString().padLeft(2, "0");
  final hrs = twoDigits(timerTime.inHours.remainder(60));
  final mins = twoDigits(timerTime.inMinutes.remainder(60));
  final sec = twoDigits(timerTime.inSeconds.remainder(60));
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        AppString.Balance,
        style: AppStyle.normal_text,
      ),
      SizedBox(height: AppLayout.getHeight(8)),
      Text("-$hrs h $mins m", style: AppStyle.normal_text)
    ],
  );
}
