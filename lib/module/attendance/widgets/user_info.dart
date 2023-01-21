import 'package:flutter/material.dart';

import '../../../../util/app_layout.dart';
import '../../../../util/app_string.dart';
import '../../../../util/app_style.dart';

Widget userInfo() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "Hi, Steve",
        style: AppStyle.title_text.copyWith(color: Colors.white),
      ),
      const Spacer(),
      Container(
        height: AppLayout.getHeight(32),
        padding: EdgeInsets.symmetric(
            horizontal: AppLayout.getWidth(16),
            vertical: AppLayout.getWidth(4)),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Center(
          child: Text(
            AppString.regular,
            style: AppStyle.normal_text.copyWith(
              color: Colors.lightGreen,
            ),
          ),
        ),
      )
    ],
  );
}