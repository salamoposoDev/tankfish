import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tank_fish/constant.dart';

class SensorcCard extends StatelessWidget {
  const SensorcCard({
    super.key,
    this.logo,
    this.value,
    this.status,
    this.name,
    this.symbol,
    this.isPressed = false,
  });
  final String? logo;
  final String? value;
  final String? status;
  final String? name;
  final String? symbol;
  final bool? isPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: isPressed! ? Colors.blue.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          // if (isPressed!)
          BoxShadow(
              blurRadius: 6,
              offset: const Offset(5, 5),
              color: isPressed! ? Colors.blue.shade200 : Colors.grey.shade300,
              inset: isPressed! ? true : false),
          if (isPressed!)
            BoxShadow(
                blurRadius: 6,
                offset: const Offset(-5, -5),
                color: isPressed! ? Colors.blue.shade200 : Colors.grey.shade300,
                inset: isPressed! ? true : false),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name ?? 'Suhu',
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value ?? '0',
                      style: GoogleFonts.roboto(
                        fontSize: isPressed! ? 30.sp : 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade800,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      ' $symbol',
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.midnightBlue),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  status ?? 'normal',
                  style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade800),
                ),
                Image.asset(
                  logo!,
                  height: 45.h,
                  color: isPressed!
                      ? Colors.orange.shade900
                      : Colors.blue.shade900,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
