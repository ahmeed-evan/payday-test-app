import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payday_app/util/app_layout.dart';
import 'package:payday_app/util/app_style.dart';

import '../module/attendance/controller/attendance_controller.dart';
class PunchButton extends StatelessWidget {
  Function onPress;

  PunchButton({
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          width: double.maxFinite,
          height: AppLayout.getHeight(42),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.6),
                side: const BorderSide(width: 1, color: Colors.white)),
            icon: const Icon(Icons.logout),
            onPressed: () => onPress(),
            label: Text(
                Get.find<AttendanceController>().isPunchedIn.value
                    ? "Punch Out"
                    : "Punch In",
                style: AppStyle.normal_text),
          ),
        ));
  }
}
