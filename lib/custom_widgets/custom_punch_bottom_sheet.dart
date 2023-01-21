import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payday_app/util/app_layout.dart';
import 'package:payday_app/util/app_style.dart';

import '../module/attendance/controller/attendance_controller.dart';
import '../util/app_string.dart';

class CustomBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .8,
      maxChildSize: .8,
      builder: (BuildContext context, ScrollController scrollController) =>
          Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        child: ListView(
          controller: scrollController,
          children: [
            _bottomSheetAppbar(context),
            Divider(color: Colors.grey.shade200, thickness: 1),
            SizedBox(height: AppLayout.getHeight(16)),
            Obx(() => _timeLayout()),
            _noteLayout(),
            _positionInfoLayout(context),
          ],
        ),
      ),
    );
  }

  _bottomSheetAppbar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 4,
          ),
          Obx(
            () => Text(
              Get.find<AttendanceController>().isPunchedIn.value
                  ? "Punch Out"
                  : "Punch In",
              style: AppStyle.normal_text_black,
            ),
          ),
          const Spacer(
            flex: 3,
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  _timeLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _inTimelayout(),
          const Spacer(
            flex: 2,
          ),
          _verticalDivider(),
          SizedBox(
            width: AppLayout.getWidth(16),
          ),
          _outTimelayout(),
          const Spacer(
            flex: 2,
          ),
          _verticalDivider(),
          SizedBox(
            width: AppLayout.getWidth(16),
          ),
          _balancelayout(),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  _inTimelayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppString.In,
          style: AppStyle.normal_text_black,
        ),
        SizedBox(height: AppLayout.getHeight(8)),
        Text(
            Get.find<AttendanceController>().isPunchedIn.value
                ? Get.find<AttendanceController>().currentTime.value
                : DateFormat('h:mma').format(DateTime.now()),
            style: AppStyle.normal_text_black)
      ],
    );
  }

  _outTimelayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.Out,
          style: AppStyle.normal_text_black,
        ),
        SizedBox(height: AppLayout.getHeight(8)),
        Text(
            Get.find<AttendanceController>().isPunchedIn.value
                ? DateFormat('h:mma').format(DateTime.now())
                : "-",
            style: AppStyle.normal_text_black)
      ],
    );
  }

  _verticalDivider() {
    return Container(
      height: AppLayout.getHeight(20),
      padding: const EdgeInsets.all(1),
      color: Colors.grey.shade200,
    );
  }

  _balancelayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.Total,
          style: AppStyle.normal_text_black,
        ),
        SizedBox(height: AppLayout.getHeight(8)),
        Text("-", style: AppStyle.normal_text_black),
      ],
    );
  }

  _noteLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppLayout.getHeight(20),
          horizontal: AppLayout.getWidth(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          AppString.note_text,
          style: AppStyle.normal_text.copyWith(color: Colors.grey),
        ),
        SizedBox(height: AppLayout.getHeight(8)),
        _inputNote(),
        SizedBox(height: AppLayout.getHeight(16)),
      ]),
    );
  }

  _inputNote() {
    return TextField(
      controller: Get.find<AttendanceController>().note,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          hintText: "Add Note Here",
          hintStyle: AppStyle.normal_text.copyWith(color: Colors.grey),
          isDense: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
      maxLines: 5,
      minLines: 3,
    );
  }

  _positionInfoLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 120,
          width: double.maxFinite,
          child: Image.asset(
            'assets/gmap.jpg',
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: AppLayout.getHeight(16)),
        Obx(() => _currentLocation()),
        SizedBox(height: AppLayout.getHeight(16)),
        _deviceIP(),
        SizedBox(height: AppLayout.getHeight(16)),
        Obx(() => _buttonLayout(context)),
      ]),
    );
  }

  _currentLocation() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          padding: EdgeInsets.all(4),
          child: Icon(
            Icons.my_location,
            color: Colors.blueAccent,
          ),
        ),
        SizedBox(
          width: AppLayout.getWidth(8),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Get.find<AttendanceController>().isPunchedIn.value
                  ? Get.find<AttendanceController>().addressOut.value
                  : Get.find<AttendanceController>().address.value,
              style: AppStyle.normal_text_black
                  .copyWith(fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'My Location',
              style: AppStyle.small_text
                  .copyWith(fontWeight: FontWeight.w400, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  _deviceIP() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          padding: EdgeInsets.all(4),
          child: Icon(
            Icons.location_on_outlined,
            color: Colors.blueAccent,
          ),
        ),
        SizedBox(
          width: AppLayout.getWidth(8),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Get.find<AttendanceController>().isPunchedIn.value
                  ? Get.find<AttendanceController>().ipAddOut.value
                  : Get.find<AttendanceController>().ipAddIn.value,
              style: AppStyle.normal_text_black
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            Text(
              'IP Address',
              style: AppStyle.small_text
                  .copyWith(fontWeight: FontWeight.w400, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  _buttonLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _cancelButton(context),
        SizedBox(width: AppLayout.getWidth(10)),
        _punchButton(context),
      ],
    );
  }

  _cancelButton(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: const BorderSide(width: 1, color: Colors.grey)),
        onPressed: () => Navigator.of(context).pop(),
        child: const Text(
          "Cancel",
          style: AppStyle.normal_text_black,
        ),
      ),
    );
  }

  _punchButton(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: const BorderSide(width: 1, color: Colors.grey)),
        onPressed: () async {
          Get.find<AttendanceController>().isPunchedIn.value
              ? await Get.find<AttendanceController>().stopTimer()
              : await Get.find<AttendanceController>().startTimer();
          Navigator.of(context).pop();
        },
        child: Text(
          Get.find<AttendanceController>().isPunchedIn.value
              ? "Punch Out"
              : "Punch In",
          style: AppStyle.normal_text,
        ),
      ),
    );
  }
}
