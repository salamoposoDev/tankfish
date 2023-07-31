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
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(10, 10),
            color: AppColors.midnightBlue.withOpacity(0.2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'lib/icons/farmer.png',
                height: 50.h,
              ),
              Expanded(
                child: Text(
                  'Halo, Jangan lupa cek kondisi ikanmu hari ini',
                  style: GoogleFonts.mulish(
                    color: AppColors.midnightBlue,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Konsumsi Pakan',
                    style: GoogleFonts.poppins(
                      color: AppColors.midnightBlue,
                      fontWeight: FontWeight.w300,
                      fontSize: 12.sp,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: usedFeed != null ? usedFeed.toString() : '2,3',
                      style: GoogleFonts.poppins(
                        color: AppColors.midnightBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: 28.sp,
                      ),
                      children: [
                        const TextSpan(
                          text: ' kg',
                        ),
                        TextSpan(
                          text: '/day',
                          style: GoogleFonts.mulish(
                            color: AppColors.midnightBlue,
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
                        color: AppColors.blue,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        waterTemp != null ? '$waterTemp °C' : '26°C',
                        style: GoogleFonts.mulish(
                          color: AppColors.midnightBlue,
                          fontWeight: FontWeight.w400,
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
                        color: AppColors.blue,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        phValue != null ? '$phValue' : '7.5',
                        style: GoogleFonts.mulish(
                          color: AppColors.midnightBlue,
                          fontWeight: FontWeight.w400,
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
                        color: AppColors.blue,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        oxygenValue != null ? '$oxygenValue %' : '60%',
                        style: GoogleFonts.mulish(
                          color: AppColors.midnightBlue,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Oksigen',
                    style: GoogleFonts.roboto(
                      color: AppColors.midnightBlue,
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
