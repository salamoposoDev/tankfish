import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite.w,
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info,
            color: Colors.red,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              'Pakan hampir habis!, segera lalukan pengisian ulang agar ikan makan tepat waktu!',
              style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
