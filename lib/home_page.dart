import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tank_fish/constant.dart';
import 'package:tank_fish/dashboard/screens/dashboard.dart';
import 'package:tank_fish/history/history_page.dart';
import 'package:tank_fish/models/realtime_sensors.dart';
import 'package:tank_fish/sensors/realtime_chart.dart';
import 'package:tank_fish/sensors/sensors_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final page = [
    DashboardScreen(),
    SensorPage(),
    HistoryPage(),
    Center(child: Text('Under Developmnet')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle:
            GoogleFonts.poppins(color: AppColors.midnightBlue, fontSize: 12.sp),
        selectedLabelStyle:
            GoogleFonts.poppins(color: AppColors.blue, fontSize: 12.sp),
        backgroundColor: AppColors.white,
        elevation: 1,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Dashboard',
            icon: Image.asset(
              'lib/icons/dashboard.png',
              height: 18.h,
            ),
            activeIcon: Image.asset(
              'lib/icons/dashboard.png',
              height: 18.h,
              color: AppColors.blue,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Sensors',
            icon: Image.asset(
              'lib/icons/sensors.png',
              height: 18.h,
            ),
          ),
          BottomNavigationBarItem(
            label: 'History',
            icon: Image.asset(
              'lib/icons/history.png',
              height: 18.h,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Image.asset(
              'lib/icons/setting.png',
              height: 18.h,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: page[currentIndex],
      ),
    );
  }
}
