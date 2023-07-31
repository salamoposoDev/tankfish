import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tank_fish/constant.dart';
import 'package:tank_fish/dashboard/widgets/signal_strange.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Under Development',
                // style: GoogleFonts.poppins(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w500,
                //     color: AppColors.midnightBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
