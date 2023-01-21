import 'package:flutter/material.dart';

import '../util/app_layout.dart';
import '../util/app_string.dart';
import '../util/app_style.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppLayout.getHeight(10),
          horizontal: AppLayout.getWidth(20)),
      color: Colors.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(
          AppString.app_name,
          style: AppStyle.title_text.copyWith(fontStyle: FontStyle.italic),
        ),
        const Spacer(),
        Icon(
          Icons.notifications_none,
          color: Colors.blue,
          size: AppLayout.getHeight(24),
        )
      ]),
    );
  }
}
