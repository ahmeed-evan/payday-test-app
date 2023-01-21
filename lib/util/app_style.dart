import 'package:flutter/material.dart';
import 'package:payday_app/util/app_layout.dart';
import 'app_color.dart';

class AppStyle {
  static const title_text = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
  static const extra_small_text = TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static const extra_small_text_black = TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static const small_text = TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static const small_text_black = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static const normal_text = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static const normal_text_black = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle large_text = TextStyle(
    fontSize: AppLayout.getHeight(18),
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
}
