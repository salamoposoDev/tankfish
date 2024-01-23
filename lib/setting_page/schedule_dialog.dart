import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleDialog extends StatefulWidget {
  const ScheduleDialog({
    super.key,
    required this.onSave,
  });
  final void Function(TimeOfDay timeOfDay, int selectedAmount) onSave;

  @override
  State<ScheduleDialog> createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  TimeOfDay selectedTime = TimeOfDay.now();
  int selectedValue = 0;

  @override
  void initState() {
    selectedValue = 250;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(selectedTime.toString());
    return AlertDialog(
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      title: Text(
        'Tambah jadwal',
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: Colors.grey.shade900),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onSave(selectedTime, selectedValue!);
          },
          child: Text(
            'Save',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
            Colors.grey,
          )),
          child: Text(
            'Cancel',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: Colors.white),
          ),
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'waktu',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w300,
                          fontSize: 14.sp,
                          color: Colors.grey.shade900),
                    ),
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: () async {
                        final timeSelect = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );

                        if (timeSelect != null) {
                          String formattedTime =
                              '${timeSelect.hour}:${timeSelect.minute}';
                          log(formattedTime);
                          setState(() {
                            selectedTime = timeSelect;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            '${selectedTime.hour}: ${selectedTime.minute}',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                                color: Colors.grey.shade600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                children: [
                  Text(
                    'Jumlah',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w300,
                        fontSize: 14.sp,
                        color: Colors.grey.shade900),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(8.r),
                      underline: Container(),
                      iconEnabledColor: Colors.blue,
                      isDense: true,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: Colors.grey.shade600),
                      hint: Text('$selectedValue gr'),
                      items: const [
                        DropdownMenuItem(
                          value: 250,
                          child: Text('250 gr'),
                        ),
                        DropdownMenuItem(
                          value: 500,
                          child: Text('500 gr'),
                        ),
                        DropdownMenuItem(
                          value: 1000,
                          child: Text('1000 gr'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
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
