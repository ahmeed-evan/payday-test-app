import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:dart_ipify/dart_ipify.dart';
import '../model/attendance_info.dart';

class AttendanceController extends GetxController {
  final _currentTime = '-'.obs;
  late String _inNote;
  late String _outNote;
  final RxString _ipv4In = ''.obs;
  final RxString _ipv4Out = ''.obs;
  final _currentTimeOut = '-'.obs;
  final _isPunchedIn = false.obs;
  final RxBool _isTimerRunning = false.obs;
  final Rx<Duration> _duration = const Duration().obs;
  final Rx<Duration> _countdownDuration = const Duration(hours: 9).obs;
  Timer? _timer;
  final TextEditingController note = TextEditingController();
  final RxList<AttendanceInfo> attendanceLog = <AttendanceInfo>[].obs;

  RxString get currentTime => _currentTime;

  RxString get ipAddIn => _ipv4In;

  RxString get ipAddOut => _ipv4Out;

  RxString get currentTimeOut => _currentTimeOut;

  Rx<Duration> get duration => _duration;

  Rx<Duration> get countdown => _countdownDuration;

  RxBool get isTimerRunning => _isTimerRunning;

  RxBool get isPunchedIn => _isPunchedIn;

  startTimer() {
    _inNote = note.text;
    _isTimerRunning.value = true;
    _isPunchedIn.value = true;
    _currentTime.value = DateFormat('h:mma').format(DateTime.now());
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) => _addTime());
  }

  stopTimer() async {
    _outNote = note.text;
    _isTimerRunning.value = false;
    _isPunchedIn.value = false;
    await addInfo();
    _currentTime.value = "-";
    _timer?.cancel();
    _duration.value = const Duration();
    _countdownDuration.value = const Duration(hours: 9);
  }

  _addTime() {
    _duration.value = Duration(minutes: _duration.value.inMinutes + 1);
    _countdownDuration.value =
        Duration(minutes: _countdownDuration.value.inMinutes - 1);
  }

  late double lat;

  late double long;

  RxString address = "Current Location".obs;
  RxString addressOut = "Current Location".obs;

  getLatLong() async {
    Future<Position> data = _determinePosition();
    data.then((value) {
      lat = value.latitude;
      long = value.longitude;

      getAddress(value.latitude, value.longitude);
    }).catchError((error) {
      print("Error $error");
    });
  }

  //For convert lat long to address
  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    _isPunchedIn.value
        ? addressOut.value =
            placemarks[0].street! + " " + placemarks[0].country!
        : address.value = placemarks[0].street! + " " + placemarks[0].country!;

    for (int i = 0; i < placemarks.length; i++) {
      print("INDEX $i ${placemarks[i]}");
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  addInfo() {
    attendanceLog.add(AttendanceInfo(
        date: DateFormat.MMMMEEEEd().format(DateTime.now()),
        inTime: _currentTime.value,
        outTime: DateFormat('h:mma').format(DateTime.now()),
        punchOutIp: _ipv4Out.value,
        punchInIp: _ipv4In.value,
        punchInLocation: address.value,
        punchOutLocation: addressOut.value,
        punchInNote: _inNote,
        punchOutNote: _outNote));
  }

  getIp() async {
    if (_isPunchedIn.value) {
      _ipv4Out.value = await Ipify.ipv4();
    } else {
      _ipv4In.value = await Ipify.ipv4();
    }
  }
}
