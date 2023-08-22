import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:tank_fish/constant.dart';
import 'package:tank_fish/dashboard/widgets/card_schedule.dart';
import 'package:tank_fish/models/history_schedule_model.dart';

class FeedStatusCard extends StatelessWidget {
  FeedStatusCard({
    super.key,
    this.schedule,
    this.lastFeed,
    required this.onPressed,
    required this.servoStatus,
    required this.disable,
  });
  final List<Map<String, dynamic>>? schedule;
  final HistorySchedule? lastFeed;
  final VoidCallback onPressed;
  final int servoStatus;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    int timestamp = lastFeed?.time != null ? lastFeed!.time!.toInt() : 0;
    String formatedTime = parseTimestampToTime(timestamp);

    if (disable) {
      return Container(
        width: double.maxFinite.w,
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              offset: const Offset(5, 5),
              color: AppColors.midnightBlue.withOpacity(0.1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (lastFeed?.time != null && lastFeed?.amount != null)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Terakhir',
                        style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.midnightBlue),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lastFeedTime(timestamp),
                            style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          SizedBox(width: 6.w),
                          Icon(
                            Icons.lock_clock,
                            size: 16.h,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'lib/icons/timeForwad.png',
                          height: 18.h,
                        ),
                        Text(
                          formatedTime,
                          style: GoogleFonts.poppins(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.midnightBlue),
                        ),
                        VerticalDivider(
                          thickness: 3.h,
                          indent: 5,
                          endIndent: 5,
                        ),
                        Image.asset(
                          'lib/icons/soup.png',
                          height: 18.h,
                        ),
                        Row(
                          children: [
                            Text(
                              '${lastFeed!.amount}',
                              style: GoogleFonts.poppins(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.midnightBlue),
                            ),
                            Text(
                              ' gr',
                              style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.midnightBlue),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1.h),
                  SizedBox(height: 8.h),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jadwal',
                  style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.midnightBlue),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ListView.builder(
              shrinkWrap: true,
              itemCount: schedule!.length > 3 ? 3 : schedule!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final time = schedule![index]['time'].toString();
                final amount = schedule![index]['amount'];
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: CardSchedule(
                    time: time,
                    value: amount,
                  ),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: servoStatus == 1 ? null : onPressed,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.blue.shade300;
                          }
                          return Colors.blue;
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: servoStatus == 1
                        ? Transform.scale(
                            scale: 0.8,
                            child: const CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                        : Text(
                            'Beri makan sekarang',
                            style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                  ),
                ),
              ],
            )
          ],
        ),
      ).blurred(
          borderRadius: BorderRadius.circular(12.r),
          blur: 2,
          colorOpacity: 0.3,
          blurColor: Colors.grey.shade200,
          overlay: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 70.h,
                color: Colors.grey.shade700,
              ),
              Text(
                'Auto feeder belum terpasang!',
                style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    // fontWeight: FontWeight.w500,
                    color: Colors.black),
              )
            ],
          ));
    }
    return Container(
      width: double.maxFinite.w,
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: const Offset(5, 5),
            color: AppColors.midnightBlue.withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (lastFeed?.time != null && lastFeed?.amount != null)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Terakhir',
                      style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.midnightBlue),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lastFeedTime(timestamp),
                          style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.timelapse,
                          size: 16.h,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'lib/icons/timeForwad.png',
                        height: 18.h,
                      ),
                      Text(
                        formatedTime,
                        style: GoogleFonts.poppins(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.midnightBlue),
                      ),
                      VerticalDivider(
                        thickness: 3.h,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Image.asset(
                        'lib/icons/soup.png',
                        height: 18.h,
                      ),
                      Row(
                        children: [
                          Text(
                            '${lastFeed!.amount}',
                            style: GoogleFonts.poppins(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.midnightBlue),
                          ),
                          Text(
                            ' gr',
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.midnightBlue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1.h),
                SizedBox(height: 8.h),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jadwal',
                style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.midnightBlue),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ListView.builder(
            shrinkWrap: true,
            itemCount: schedule!.length > 3 ? 3 : schedule!.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final time = schedule![index]['time'].toString();
              final amount = schedule![index]['amount'];
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: CardSchedule(
                  time: time,
                  value: amount,
                ),
              );
            },
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: servoStatus == 1 ? null : onPressed,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.blue.shade300;
                        }
                        return Colors.blue;
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: servoStatus == 1
                      ? Transform.scale(
                          scale: 0.8,
                          child: const CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        )
                      : Text(
                          'Beri makan sekarang',
                          style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

String parseTimestampToTime(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String formattedTime =
      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  return formattedTime;
}

String lastFeedTime(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

  if (dateTime.isAfter(today)) {
    return 'Hari Ini';
  } else if (dateTime.isAfter(yesterday)) {
    return 'Kemarin';
  } else {
    DateFormat format = DateFormat("dd MMMM yy");
    String formattedDate = format.format(dateTime);
    return formattedDate;
  }
}
