import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class historySensorCard extends StatelessWidget {
  const historySensorCard({
    super.key,
    this.backgroundColor = Colors.white,
    this.onTab,
    this.totalData,
    this.lastUpdate,
    this.logo,
    this.maxValue,
    this.minValue,
    this.average,
    this.name,
    this.symbol,
  });
  final Color? backgroundColor;
  final VoidCallback? onTab;

  final int? totalData;
  final String? lastUpdate;
  final String? logo;
  final String? maxValue;
  final String? minValue;
  final String? average;
  final String? name;
  final String? symbol;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            // border: Border.all(color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      logo.toString(),
                      height: 30.h,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      name.toString(),
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Hari ini',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Update Terakhir',
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
                Text(
                  lastUpdate.toString(),
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tertinggi',
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
                Text(
                  '$maxValue $symbol',
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Terendah',
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
                Text(
                  '$minValue $symbol',
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rata-rata',
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
                Text(
                  '$average $symbol',
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
                Text(
                  '${totalData} data',
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
