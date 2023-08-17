import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CardSchedule extends StatelessWidget {
  const CardSchedule({
    super.key,
    required this.time,
    required this.value,
    this.onDelete,
    this.enableDelete = false,
  });
  final String time;
  final int value;
  final VoidCallback? onDelete;
  final bool? enableDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/icons/timeForwad.png',
                    height: 14.h,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    time,
                    style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/icons/soup.png',
                    height: 18.h,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '$value gr',
                    style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (enableDelete!)
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: InkWell(
              onTap: onDelete,
              child: Icon(
                Icons.delete_outlined,
                size: 24.h,
                color: Colors.red.shade300,
              ),
            ),
          ),
      ],
    );
  }
}
