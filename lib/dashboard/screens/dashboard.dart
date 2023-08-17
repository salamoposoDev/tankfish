import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tank_fish/constant.dart';
import 'package:tank_fish/dashboard/widgets/common_info_card.dart';
import 'package:tank_fish/dashboard/widgets/device_info_card.dart';
import 'package:tank_fish/dashboard/widgets/feed_status_card.dart';
import 'package:tank_fish/dashboard/widgets/tankfish_dropdown.dart';
import 'package:tank_fish/providers.dart';
import 'package:tank_fish/providers/control_servo_provider.dart';
import 'package:tank_fish/providers/stream_data_sensor.dart';

class DashboardScreen extends ConsumerWidget {
  DashboardScreen({super.key});

  final List<String> _dropdownItems = [
    'Tank Lele 1',
    'Tank Lele 2',
    'Tank Udang 1',
    'Tank Udang 2',
    'Tank Kakap 1',
    'Tank Kakap 2'
  ];
  final lockList = [false, true, true, true, true, true];

  final List<String> _dropdownItemsValue = [
    's-A0:B7:65:DC:42:F0',
    's-A0:B7:65:DD:30:44',
    's-A0:B7:65:DC:5C:44',
    's-A0:B7:65:DD:C8:E8',
    's-E0:5A:1B:A1:61:F0',
    's-A0:B7:65:DC:65:7C'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(selectedTankProvider);
    final selectedValue = ref.watch(childPathProvider);
    final selectedLock = ref.watch(selectedLockProvider);
    final dataSensors = ref.watch(sensorsStreamProvider(selectedValue));
    final deviceInfo = ref.watch(getDeviceInfoProvider(selectedValue));
    final schedule = ref.watch(getScheduleProvider('au-A0:B7:65:DD:58:50'));
    final history =
        ref.watch(getHistoryScheduleProvider('au-A0:B7:65:DD:58:50'));
    final servoStatus =
        ref.watch(getServoStatusProvider('au-A0:B7:65:DD:58:50'));
    if (dataSensors.isLoading ||
        deviceInfo.isLoading ||
        schedule.isLoading ||
        history.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (dataSensors.hasError ||
        deviceInfo.hasError ||
        schedule.hasError ||
        history.hasError) {
      return const Center(child: Text('error'));
    }

    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(dataSensors.value!.time! * 1000);
    final status = isDeviceOnline(dateTime);
    final lastUpdate = checkRelativeTime(dataSensors.value!.time!);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TankFisDropdown(
                          onSelect: (value) {
                            var index = int.parse(value);
                            final selectedValue = _dropdownItemsValue[index];
                            ref.read(selectedLockProvider.notifier).state =
                                lockList[index];
                            ref.read(selectedTankProvider.notifier).state =
                                _dropdownItems[index];
                            ref
                                .read(childPathProvider.notifier)
                                .update((state) => selectedValue);
                          },
                          selectedItem: selectedItem,
                          dropdownItems: _dropdownItems,
                          dropdownItemsValue: _dropdownItemsValue),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 16.r,
                        child: const Icon(
                          Icons.person,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              CommonInfoCard(
                waterTemp: dataSensors.value!.waterTemp!.toInt(),
                phValue: dataSensors.value!.ph.toString(),
                oxygenValue: dataSensors.value!.tds,
              ),
              // Column(
              //   children: [
              //     SizedBox(height: 16.h),
              //     NotificationCard(),
              //   ],
              // ),
              SizedBox(height: 16.h),
              Text(
                'Otomasi',
                style:
                    GoogleFonts.poppins(color: Colors.black, fontSize: 16.sp),
              ),
              SizedBox(height: 8.h),
              FeedStatusCard(
                disable: selectedLock,
                servoStatus: servoStatus,
                onPressed: () {
                  FirebaseDatabase.instance
                      .ref('automation/au-A0:B7:65:DD:58:50/control/servo')
                      .set(1);
                },
                lastFeed: history.value!.last,
                schedule: schedule.value,
              ),
              SizedBox(height: 16.h),
              Text(
                'Info Perangkat',
                style:
                    GoogleFonts.poppins(color: Colors.black, fontSize: 16.sp),
              ),
              SizedBox(height: 8.h),
              DeviceInfoCard(
                status: status == true ? 'Online' : 'Offline',
                rssi: deviceInfo.value!.rssi,
                ipAddress: deviceInfo.value!.ipAddr,
                macAddr: deviceInfo.value!.macAddr,
                time: lastUpdate,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      )),
    );
  }
}

bool isDeviceOnline(DateTime dbTime) {
  DateTime currentDateTime = DateTime.now();
  int toleranceSeconds = 30;
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
