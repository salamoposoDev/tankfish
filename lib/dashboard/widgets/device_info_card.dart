import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tank_fish/constant.dart';
import 'package:tank_fish/dashboard/widgets/signal_strange.dart';

class DeviceInfoCard extends StatefulWidget {
  const DeviceInfoCard({
    super.key,
    this.rssi,
    this.ipAddress,
    this.macAddr,
    this.status,
    this.time,
  });
  final int? rssi;
  final String? ipAddress;
  final String? macAddr;
  final String? status;
  final String? time;

  @override
  State<DeviceInfoCard> createState() => _DeviceInfoCardState();
}

class _DeviceInfoCardState extends State<DeviceInfoCard> {
  bool showMore = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite.w,
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade400,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                showMore = !showMore;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sensors',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.midnightBlue,
                  ),
                ),
                Icon(
                  !showMore
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: AppColors.blue,
                  size: 24.h,
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Divider(thickness: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status perangkat',
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                    color: AppColors.midnightBlue),
              ),
              Text(
                widget.status ?? 'Offline',
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                    color: widget.status == 'Online'
                        ? AppColors.blue
                        : Colors.red),
              ),
            ],
          ),
          Divider(thickness: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kekuatan sinyal',
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                    color: AppColors.midnightBlue),
              ),
              SignalStrange(
                signalStrength: widget.rssi ?? -50,
              ),
            ],
          ),
          if (showMore)
            Column(
              children: [
                Divider(thickness: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Terakhir Update',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.midnightBlue),
                    ),
                    Text(
                      widget.time ?? '00:00',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.midnightBlue),
                    ),
                  ],
                ),
                Divider(thickness: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Alamat IP',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.midnightBlue),
                    ),
                    Text(
                      widget.ipAddress ?? '0.0.0.0',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.midnightBlue),
                    ),
                  ],
                ),
                Divider(thickness: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Alamat Mac',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.midnightBlue),
                    ),
                    Text(
                      widget.macAddr ?? '00:00:00:00:00:00',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.midnightBlue),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
