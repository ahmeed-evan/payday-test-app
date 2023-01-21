import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../util/app_layout.dart';
import '../../../../util/app_style.dart';
import '../controller/attendance_controller.dart';

Widget timeStory() {
  Duration timerTime = Get.find<AttendanceController>().duration.value;
  String twoDigits(int num) => num.toString().padLeft(2, "0");
  final hrs = twoDigits(timerTime.inHours.remainder(60));
  final mins = twoDigits(timerTime.inMinutes.remainder(60));

  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: hrs,
              style: AppStyle.large_text.copyWith(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: " h ",
              style: AppStyle.small_text,
            ),
            TextSpan(
              text: mins,
              style: AppStyle.large_text.copyWith(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: " m ",
              style: AppStyle.small_text,
            ),
          ]),
        ),
        SizedBox(height: AppLayout.getHeight(8)),
        Text(
          "Worked",
          style: AppStyle.small_text,
        ),
      ],
    ),
  );
}
