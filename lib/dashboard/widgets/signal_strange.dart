import 'package:flutter/material.dart';
import 'package:tank_fish/constant.dart';

class SignalStrange extends StatefulWidget {
  const SignalStrange({
    super.key,
    this.signalStrength = -30,
  });
  final int? signalStrength;

  @override
  State<SignalStrange> createState() => _SignalStrangeState();
}

class _SignalStrangeState extends State<SignalStrange> {
  List<double> height = [6, 8, 10, 12, 14];
  var color = List.generate(5, (index) => AppColors.blue);
  @override
  Widget build(BuildContext context) {
    if (widget.signalStrength! >= -30) {
      setState(() {
        color = [
          AppColors.blue,
          AppColors.blue,
          AppColors.blue,
          AppColors.blue,
          AppColors.blue,
        ];
      });
    } else if (widget.signalStrength! >= -50) {
      setState(() {
        color = [
          AppColors.blue,
          AppColors.blue,
          AppColors.blue,
          AppColors.blue,
          Colors.transparent,
        ];
      });
    } else if (widget.signalStrength! >= -70) {
      setState(() {
        color = [
          AppColors.blue,
          AppColors.blue,
          AppColors.blue,
          Colors.transparent,
          Colors.transparent,
        ];
      });
    } else if (widget.signalStrength! >= -80) {
      setState(() {
        color = [
          AppColors.blue,
          AppColors.blue,
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
        ];
      });
    } else {
      setState(() {
        color = [
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
        ];
      });
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ...List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Container(
              height: height[index],
              width: 3,
              decoration: BoxDecoration(
                color: color[index],
                border: Border.all(width: 0.6, color: AppColors.blue),
              ),
            ),
          ),
        )
      ],
    );
  }
}
