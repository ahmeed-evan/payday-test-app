import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payday_app/custom_widgets/custom_punch_bottom_sheet.dart';
import 'package:payday_app/custom_widgets/custom_punch_button.dart';
import 'package:payday_app/util/app_string.dart';
import 'package:intl/intl.dart';
import '../../../../custom_widgets/custom_log_details_bottom_sheet.dart';
import '../controller/attendance_controller.dart';
import '../widgets/blance_time.dart';
import '../widgets/getCurrentDate.dart';
import '../widgets/log_list.dart';
import '../widgets/time_story.dart';
import '../widgets/user_info.dart';

import '../../../../custom_widgets/custom_appbar.dart';
import '../../../../util/app_layout.dart';
import '../../../../util/app_style.dart';

class Attendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppbar(),
            _body(context),
          ],
        ),
      ),
    );
  }

  _body(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppLayout.getHeight(20),
                  horizontal: AppLayout.getWidth(20)),
              height: AppLayout.getHeight(450),
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userInfo(),
                    getCurrentDate(),
                    SizedBox(height: AppLayout.getHeight(32)),
                    Obx(() {
                      return _timeTacker();
                    }),
                    SizedBox(height: AppLayout.getHeight(24)),
                    _attendanceTimeLayout(),
                    const Spacer(),
                    PunchButton(onPress: () async {
                      await Get.find<AttendanceController>().getIp();
                      await Get.find<AttendanceController>().getLatLong();
                      showModalBottomSheet(
                        enableDrag: false,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => CustomBottomSheet(),
                      );
                    }),
                    _attendanceLogText(),
                  ]),
            ),
            _todaysLogIntroText(),
            Obx(() => logList()),
          ],
        ),
      ),
    );
  }

  _timeTacker() {
    return Stack(
      alignment: Alignment.center,
      children: [_progressBar(), Obx(() => timeStory())],
    );
  }

  _attendanceTimeLayout() {
    return Obx(
          () =>
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              inTimelayout(),
              const Spacer(),
              _verticalDivider(),
              SizedBox(
                width: AppLayout.getWidth(16),
              ),
              _outTimelayout(),
              const Spacer(),
              _verticalDivider(),
              SizedBox(
                width: AppLayout.getWidth(16),
              ),
              balancelayout(),
            ],
          ),
    );
  }

  inTimelayout() {
    String currentTime = Get
        .find<AttendanceController>()
        .currentTime
        .value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppString.In,
          style: AppStyle.normal_text,
        ),
        SizedBox(height: AppLayout.getHeight(8)),
        Text(currentTime, style: AppStyle.normal_text)
      ],
    );
  }

  _outTimelayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.Out,
          style: AppStyle.normal_text,
        ),
        SizedBox(height: AppLayout.getHeight(8)),
        Text("-", style: AppStyle.normal_text)
      ],
    );
  }

  _verticalDivider() {
    return Container(
      height: AppLayout.getHeight(20),
      padding: const EdgeInsets.all(1),
      color: Colors.white,
    );
  }

  _attendanceLogText() {
    return Center(
      child: TextButton.icon(
        onPressed: () {},
        icon: const Text(
          "Attendance log",
          style: AppStyle.small_text,
        ),
        label: const Icon(Icons.arrow_forward_outlined,
            color: Colors.white, size: 16),
      ),
    );
  }

  _todaysLogIntroText() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppLayout.getHeight(20),
          horizontal: AppLayout.getWidth(20)),
      child: Text(
        AppString.todays_log,
        style: AppStyle.normal_text.copyWith(color: Colors.grey),
      ),
    );
  }

  _progressBar() {
    var value = Get
        .find<AttendanceController>()
        .duration
        .value
        .inMinutes;
    var isStarted = Get
        .find<AttendanceController>()
        .isTimerRunning
        .value;
    return SizedBox(
        height: AppLayout.getHeight(150),
        width: AppLayout.getWidth(150),
        child: CircularProgressIndicator(
          strokeWidth: 10,
          value: isStarted ? value + 1 / 540 : 0,
          backgroundColor: Colors.blue.shade400,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ));
  }
}
