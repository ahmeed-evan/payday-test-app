import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../util/app_style.dart';

Widget getCurrentDate() {
  return Text(
    DateFormat.MMMMEEEEd().format(DateTime.now()),
    style: AppStyle.normal_text,
  );
}
