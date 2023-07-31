import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tank_fish/constant.dart';

class FeedStatusCard extends StatelessWidget {
  const FeedStatusCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite.w,
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            offset: const Offset(10, 10),
            color: AppColors.midnightBlue.withOpacity(0.1),
          ),
          const BoxShadow(
            blurRadius: 20,
            offset: Offset(-10, -10),
            color: AppColors.white,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Next Feed',
            style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.midnightBlue),
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
                  '12:00',
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
                Text(
                  '100gr',
                  style: GoogleFonts.poppins(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.midnightBlue),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: double.infinity.w,
            height: 40.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: const MaterialStatePropertyAll(AppColors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              child: Text(
                'Beri pakan sekarang',
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
