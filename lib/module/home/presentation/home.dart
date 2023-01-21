import 'package:flutter/material.dart';
import 'package:flutter/services.dart';import 'package:payday_app/module/leave/presentation/leave.dart';
import 'package:payday_app/module/more/presentation/more.dart';
import 'package:payday_app/module/payslip/presentation/payslip.dart';

import '../../attendance/view/attendance.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final _screens = <Widget>[Attendance(), Leave(), PaySlip(), More()];

  final _items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
        icon: Icon(Icons.watch_later), label: "Attendance"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today_outlined), label: "Leave"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sticky_note_2_outlined), label: "Payslip"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.dashboard_customize_outlined), label: "More"),
  ];

  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        child: _screens[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: _items,
        currentIndex: currentIndex,
        onTap: (index) => onTap(index),
      ),
    );
  }
}
