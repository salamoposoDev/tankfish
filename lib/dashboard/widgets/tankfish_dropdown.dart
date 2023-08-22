import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tank_fish/constant.dart';

class TankFisDropdown extends ConsumerStatefulWidget {
  const TankFisDropdown(
      {super.key,
      this.dropdownItems,
      this.dropdownItemsValue,
      this.onSelect,
      required this.selectedItem,
      required this.idAndName});

  final List<String>? dropdownItems;
  final List<String>? dropdownItemsValue;
  final List<Map<String, dynamic>> idAndName;
  final void Function(String)? onSelect;
  final String selectedItem;

  @override
  ConsumerState<TankFisDropdown> createState() => _TankFisDropdownState();
}

class _TankFisDropdownState extends ConsumerState<TankFisDropdown> {
  String selectedValue = '';

  @override
  void initState() {
    super.initState();
    selectedValue = widget.idAndName[0]['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1.w),
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: const Offset(2, 2),
            color: AppColors.midnightBlue.withOpacity(0.1),
          )
        ],
      ),
      child: DropdownButton<String>(
          iconEnabledColor: Colors.blue,
          borderRadius: BorderRadius.circular(10.r),
          underline: Container(),
          style: GoogleFonts.roboto(fontSize: 16.sp, color: Colors.black),
          isDense: true,
          // value: _selectedValue,
          hint: Text(
            widget.selectedItem,
            style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.8)),
          ),
          onChanged: (newValue) {
            widget.onSelect!(newValue!);
          },
          items: [
            for (int i = 0; i < widget.idAndName.length; i++)
              DropdownMenuItem<String>(
                value: i.toString(),
                child: Text(widget.idAndName[i]['name']),
              ),
          ]),
    );
  }
}
