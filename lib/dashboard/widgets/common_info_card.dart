import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tank_fish/constant.dart';

class CommonInfoCard extends StatelessWidget {
  const CommonInfoCard({
    super.key,
    this.phValue,
    this.waterTemp,
    this.oxygenValue,
    this.usedFeed,
  });
  final String? phValue;
  final int? waterTemp;
  final int? oxygenValue;
  final double? usedFeed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16).h,
      width: double.maxFinite.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: const Offset(5, 5),
            color: Colors.grey.shade300,
          ),
          const BoxShadow(
            blurRadius: 2,
            offset: Offset(-5, -5),
            color: Colors.white,
          ),
        ],
      ),
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
                    height: 45.h,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Tank',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: AppColors.midnightBlue),
                  ),
                  Text(
                    'Fis',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: Colors.black),
                  ),
                ],
              ),
              Divider(thickness: 2.h),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Konsumsi Pakan',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.midnightBlue,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: usedFeed != null ? usedFeed.toString() : '0,0',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 28.sp,
                      ),
                      children: [
                        const TextSpan(
                          text: ' kg',
                        ),
                        TextSpan(
                          text: '/day',
                          style: GoogleFonts.mulish(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            thickness: 1.h,
            color: AppColors.midnightBlue.withOpacity(0.1),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'lib/icons/termometerLogo.png',
                        scale: 1.5.h,
                        color: Colors.black,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        waterTemp != null ? '$waterTemp °C' : '26°C',
                        style: GoogleFonts.mulish(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    'Suhu Air',
                    style: GoogleFonts.roboto(
                      color: AppColors.midnightBlue,
                      fontWeight: FontWeight.w300,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'lib/icons/hum.png',
                        scale: 1.5.h,
                        color: Colors.black,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        phValue != null ? '$phValue' : '7.5',
                        style: GoogleFonts.mulish(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'PH Air',
                    style: GoogleFonts.roboto(
                      color: AppColors.midnightBlue,
                      fontWeight: FontWeight.w300,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'lib/icons/wind.png',
                        scale: 1.5.h,
                        color: Colors.black,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        oxygenValue != null ? '$oxygenValue ppm' : '0 ppm',
                        style: GoogleFonts.mulish(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'TDS',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 12.sp,
                    ),
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
