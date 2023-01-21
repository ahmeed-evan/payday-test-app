import 'package:get/get.dart';

import 'module/attendance/controller/attendance_controller.dart';

Future<void> initApp() async {
  // Get.lazyPut<AttendanceController>(() => AuthDataSource(NetworkClient()),
  //     fenix: true);

  Get.lazyPut(() => AttendanceController(), fenix: true);
}
