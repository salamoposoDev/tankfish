import 'dart:convert';
import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tank_fish/constant.dart';
import 'package:tank_fish/dashboard/screens/bloc/get_device_info.dart';
import 'package:tank_fish/dashboard/screens/bloc/get_sensors_realtime_bolc.dart';
import 'package:tank_fish/dashboard/widgets/common_info_card.dart';
import 'package:tank_fish/dashboard/widgets/device_info_card.dart';
import 'package:tank_fish/dashboard/widgets/feed_status_card.dart';
import 'package:tank_fish/dashboard/widgets/image_card.dart';
import 'package:tank_fish/dashboard/widgets/notification_card.dart';
import 'package:tank_fish/models/device_info.dart';
import 'package:tank_fish/models/realtime_sensors.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final ValueNotifier<String> _selectedItem = ValueNotifier<String>('');

  List<String> _dropdownItems = [
    'Lele 1',
    'Lele 2',
    'Udang 1',
    'Udang 2',
    'Kakap 1',
    'Kakap 2'
  ];

  @override
  Widget build(BuildContext context) {
    // final ref = FirebaseDatabase.instance.ref('sensors');
    // ref.onValue.listen((event) {
    //   if (event.snapshot.exists) {
    //     final json = jsonEncode(event.snapshot.value);
    //     log(json);
    //   }
    // });
    late int timestamp;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'lib/icons/logo_tankfis.png',
                        height: 28.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Tank',
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: AppColors.midnightBlue),
                      ),
                      Text(
                        'Fish',
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: AppColors.blue),
                      ),
                    ],
                  ),
                  ValueListenableBuilder(
                    valueListenable: _selectedItem,
                    builder: (context, value, child) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.blue.shade400, width: 1.5),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: DropdownButton<String>(
                          iconEnabledColor: Colors.blue,
                          borderRadius: BorderRadius.circular(16.r),
                          underline: Container(),
                          style: GoogleFonts.roboto(
                              fontSize: 16, color: Colors.black),
                          isDense: true,
                          // value: value,
                          hint: Text(value),
                          onChanged: (newValue) {
                            _selectedItem.value = newValue!;
                          },
                          items: _dropdownItems
                              .map((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                        ),
                      );
                    },
                  ),
                  // Row(
                  //   children: [
                  //     CircleAvatar(
                  //       backgroundColor: AppColors.serenity,
                  //       radius: 16.r,
                  //       child: const Icon(
                  //         Icons.person,
                  //         color: AppColors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              SizedBox(height: 16.h),
              BlocBuilder<RealtimeSensorCubit, Sensors>(
                  builder: (context, data) {
                timestamp = data.time ?? 0;
                return CommonInfoCard(
                  waterTemp: data.waterTemp,
                  phValue: data.ph.toString(),
                  oxygenValue: data.oxygen,
                );
              }),
              SizedBox(height: 16.h),
              const NotificationCard(),
              SizedBox(height: 20.h),
              FeedStatusCard(),
              SizedBox(height: 16.h),
              BlocBuilder<DeviceInfoCubit, DeviceInfo>(
                  builder: (context, dataDevice) {
                DateTime dateTime =
                    DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
                final status = isDeviceOnline(dateTime);
                final lastUpdate = checkRelativeTime(timestamp);
                return DeviceInfoCard(
                  status: status == true ? 'Online' : 'Offline',
                  rssi: dataDevice.rssi,
                  ipAddress: dataDevice.ipAddr,
                  macAddr: dataDevice.macAddr,
                  time: lastUpdate,
                );
              }),
              SizedBox(height: 16.h),
              Text(
                'Latest Capture',
                style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.midnightBlue),
              ),
              SizedBox(height: 8.h),
              const ImageCard(),
            ],
          ),
        ),
      )),
    );
  }
}

bool isDeviceOnline(DateTime dbTime) {
  DateTime currentDateTime = DateTime.now();
  int toleranceSeconds = 10;
  int timeDifference = currentDateTime.difference(dbTime).inSeconds.abs();
  if (timeDifference <= toleranceSeconds) {
    return true;
  } else {
    return false;
  }
}

String checkRelativeTime(int timestamp) {
  DateTime now = DateTime.now();
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  int differenceInDays = now.difference(dateTime).inDays;

  if (differenceInDays == 0) {
    String formattedTime = DateFormat.Hm().format(dateTime);
    return 'Hari ini, $formattedTime';
  } else if (differenceInDays == 1) {
    return 'Kemarin';
  } else if (differenceInDays < 4) {
    String formattedTime = DateFormat('EEEE').format(dateTime);
    return formattedTime;
  } else {
    String formattedTime = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedTime;
  }
}
