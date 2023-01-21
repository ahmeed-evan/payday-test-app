import 'package:flutter/material.dart';
import 'package:get/get.dart';import 'package:payday_app/util/app_layout.dart';
import 'package:payday_app/util/app_style.dart';
import '../module/attendance/controller/attendance_controller.dart';
import '../util/app_string.dart';

class CustomLogBottomSheet extends StatelessWidget {
  final int index;

  CustomLogBottomSheet({required this.index});

  var controller = Get.find<AttendanceController>();

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
                SizedBox(height: AppLayout.getHeight(8)),
                Obx(() => _timeInfoLayout()),
                SizedBox(height: AppLayout.getHeight(16)),
                _timeLayout(),
                SizedBox(height: AppLayout.getHeight(16)),
                _punchInRes(),
                SizedBox(height: AppLayout.getHeight(16)),
                _positionInfoLayout(
                    context, controller.attendanceLog[index].punchInLocation!,
                    controller.attendanceLog[index].punchInIp!),
                SizedBox(height: AppLayout.getHeight(16)),
                _punchOutRes(),
                SizedBox(height: AppLayout.getHeight(16)),
                _positionInfoLayout(context,controller.attendanceLog[index].punchOutLocation!,
                    controller.attendanceLog[index].pinchOutIp!),
                SizedBox(height: AppLayout.getHeight(16)),
                _buttonLayout(context),
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
          const Text(
            "Log Details",
            style: AppStyle.normal_text_black,
          ),
          const Spacer(
            flex: 3,
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  _timeLayout() {
    var controller = Get.find<AttendanceController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _inTimelayout(controller),
          const Spacer(
            flex: 2,
          ),
          _verticalDivider(),
          SizedBox(
            width: AppLayout.getWidth(16),
          ),
          _outTimelayout(controller),
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

  _inTimelayout(AttendanceController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppString.In,
          style: AppStyle.normal_text_black,
        ),
        SizedBox(height: AppLayout.getHeight(8)),
        Text(controller.attendanceLog[index].inTime!,
            style: AppStyle.normal_text_black)
      ],
    );
  }

  _outTimelayout(AttendanceController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.Out,
          style: AppStyle.normal_text_black,
        ),
        SizedBox(height: AppLayout.getHeight(8)),
        Text(controller.attendanceLog[index].outTime!,
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


  _positionInfoLayout(BuildContext context, String address, String ip) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _currentLocation(address),
        SizedBox(height: AppLayout.getHeight(16)),
        _deviceIP(ip),
        SizedBox(height: AppLayout.getHeight(16)),
      ]),
    );
  }

  _currentLocation(String address) {
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
              address,
              style: AppStyle.normal_text_black
                  .copyWith(fontWeight: FontWeight.w400),
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

  _deviceIP(String ip) {
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
              ip,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _changeLogButton(context),
          SizedBox(width: AppLayout.getWidth(10)),
          _editButton(),
        ],
      ),
    );
  }

  _changeLogButton(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: const BorderSide(width: 1, color: Colors.grey)),
        onPressed: () => Navigator.of(context).pop(),
        child: const Text(
          "Change Log",
          style: AppStyle.normal_text_black,
        ),
      ),
    );
  }

  _editButton() {
    return Expanded(
      child: TextButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: const BorderSide(width: 1, color: Colors.grey)),
        onPressed: () {},
        child: const Text(
          "Edit",
          style: AppStyle.normal_text,
        ),
      ),
    );
  }

  _timeInfoLayout() {
    var controller = Get.find<AttendanceController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(controller.attendanceLog[index].date!,
                style: AppStyle.normal_text_black),
            Text(
              "Auto",
              style: AppStyle.extra_small_text.copyWith(color: Colors.black),
            ),
          ]),
          Container(
            height: AppLayout.getHeight(24),
            padding: EdgeInsets.symmetric(
                horizontal: AppLayout.getWidth(16),
                vertical: AppLayout.getWidth(4)),
            decoration: BoxDecoration(
                color: Colors.green.shade400,
                borderRadius: BorderRadius.circular(24)),
            child: const Center(
              child: Text(AppString.regular, style: AppStyle.extra_small_text),
            ),
          ),
        ],
      ),
    );
  }

  _punchInRes() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "Punch In",
          style: AppStyle.normal_text_black,
        ),
        SizedBox(height: AppLayout.getHeight(8)),
        Text(
          controller.attendanceLog[index].punchInNote!,
        style: AppStyle.small_text_black,
        ),
      ]),
    );
  }

  _punchOutRes() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "Punch Out",
          style: AppStyle.normal_text_black,
        ),
        SizedBox(height: AppLayout.getHeight(8)),
        Text(
          controller.attendanceLog[index].punchOutNote!,
          style: AppStyle.small_text_black,
        ),
      ]),
    );
  }
}
