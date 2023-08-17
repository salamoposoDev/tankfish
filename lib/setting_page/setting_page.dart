import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tank_fish/dashboard/widgets/card_schedule.dart';
import 'package:tank_fish/providers/stream_data_sensor.dart';
import 'package:tank_fish/setting_page/schedule_dialog.dart';
import '../constant.dart';
import '../dashboard/widgets/tankfish_dropdown.dart';

class SettingPage extends ConsumerWidget {
  SettingPage({super.key});

  final List<String> _dropdownItems = [
    'Tank Lele 1',
  ];

  final List<String> _dropdownItemsValue = [
    's-A0:B7:65:DC:42:F0',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedule = ref.watch(getScheduleProvider('au-A0:B7:65:DD:58:50'));
    final key = schedule.value!.length;

    Future<void> addSchedule({int? index, String? time, int? amount}) async {
      if (index != null && time!.isNotEmpty && amount != null) {
        try {
          await FirebaseDatabase.instance
              .ref('automation/au-A0:B7:65:DD:58:50/schedule')
              .child('time${index + 1}')
              .update({
            "time": time,
            "amount": amount,
          }).whenComplete(() {
            FirebaseDatabase.instance
                .ref('automation/au-A0:B7:65:DD:58:50/control/restart')
                .set(1);
            Navigator.pop(context);
          });
        } catch (e) {
          log(e.toString());
        }
      }
    }

    Future<void> deleteSchedule({int? index}) async {
      if (index != null) {
        try {
          await FirebaseDatabase.instance
              .ref('automation/au-A0:B7:65:DD:58:50/schedule')
              .child('time$index')
              .remove()
              .whenComplete(() {
            FirebaseDatabase.instance
                .ref('automation/au-A0:B7:65:DD:58:50/control/restart')
                .set(1);
          });
        } catch (e) {
          log(e.toString());
        }
      }
    }

    Future<dynamic> scheduleDialog({BuildContext? context, int? key}) {
      return showDialog(
          context: context!,
          builder: (context) {
            return ScheduleDialog(
              onSave: (timeOfDay, value) {
                addSchedule(
                  index: key,
                  time: '${timeOfDay.hour}:${timeOfDay.minute}',
                  amount: value,
                );
              },
            );
          });
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TankFisDropdown(
                    onSelect: (value) {},
                    selectedItem: _dropdownItems[0],
                    dropdownItems: _dropdownItems,
                    dropdownItemsValue: _dropdownItemsValue),
                Text(
                  'Setting',
                  style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.midnightBlue),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(8.h),
              decoration: BoxDecoration(
                color: Colors.blue.shade200.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.blue),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Pemberian pakan otomatis akan dihentikan jika jumlah pakan pada penampungan habis.',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      offset: Offset(1, 1),
                      color: Colors.grey,
                    )
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Schedule',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: key != 3
                            ? () {
                                scheduleDialog(context: context, key: key);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(5, 5),
                          elevation: 1,
                          // backgroundColor: Colors.blue.shade500,
                          shape: const CircleBorder(),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 18.h,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  if (schedule.isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    ListView.builder(
                      itemCount: schedule.value?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: CardSchedule(
                            time: schedule.value?[index]['time'],
                            value: schedule.value?[index]['amount'],
                            enableDelete: true,
                            onDelete: () {
                              deleteSchedule(index: key);
                            },
                          ),
                        );
                      },
                    ),
                  if (key > 2)
                    Text(
                      'Jadwal dibatasi 3 kali sehari!',
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp, color: AppColors.midnightBlue),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
