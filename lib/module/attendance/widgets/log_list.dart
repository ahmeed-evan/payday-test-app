import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payday_app/custom_widgets/custom_log_details_bottom_sheet.dart';
import 'package:payday_app/util/app_style.dart';

import '../../../../util/app_layout.dart';
import '../controller/attendance_controller.dart';

Widget logList() {
  var controller = Get.find<AttendanceController>();
  return ListView.builder(
    itemBuilder: (context, index) => _logDetails(controller, index),
    itemCount: controller.attendanceLog.length,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
  );
}

_logDetails(AttendanceController controller, int index) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${controller.attendanceLog[index].inTime} - ${controller.attendanceLog[index].outTime}',
                    style: AppStyle.normal_text_black),
                SizedBox(height: AppLayout.getHeight(8)),
                Row(
                  children: [
                    const Icon(Icons.watch_later, color: Colors.grey, size: 14),
                    SizedBox(width: AppLayout.getWidth(4)),
                    Text(
                      '0 h',
                      style: AppStyle.small_text.copyWith(color: Colors.grey),
                    ),
                    SizedBox(
                      width: AppLayout.getWidth(20),
                    ),
                    const Icon(Icons.sticky_note_2_rounded,
                        color: Colors.grey, size: 14),
                    SizedBox(width: AppLayout.getWidth(4)),
                    Text(
                      '0',
                      style: AppStyle.small_text.copyWith(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.blueAccent,
                size: 16,
              ),
              onPressed: () {
                showModalBottomSheet(
                  enableDrag: false,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: Get.context!,
                  builder: (context) => CustomLogBottomSheet(index: index),
                );
              },
            ),
          ],
        ),
        const Divider(),
      ],
    ),
  );
}
