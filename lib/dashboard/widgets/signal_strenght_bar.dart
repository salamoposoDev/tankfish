import 'package:flutter/material.dart';

class SignalStrengthBar extends StatelessWidget {
  final int signalStrength;
  final int maxSignalStrength;
  final double barHeight;
  final double barWidth;
  final int numberOfBars;

  SignalStrengthBar({
    required this.signalStrength,
    required this.maxSignalStrength,
    this.barHeight = 10,
    this.barWidth = 200,
    this.numberOfBars = 5,
  });

  @override
  Widget build(BuildContext context) {
    double strengthPercentage = signalStrength / maxSignalStrength;
    int filledBars = (strengthPercentage * numberOfBars).ceil();

    return Container(
      height: barHeight * numberOfBars,
      width: barWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(barHeight),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Stack(
        children: List.generate(
          numberOfBars,
          (index) {
            return Positioned(
              left: 0,
              right: 0,
              bottom: index * barHeight,
              child: Container(
                height: barHeight,
                color: index < filledBars
                    ? _getBarColor(strengthPercentage)
                    : Colors.transparent,
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getBarColor(double strengthPercentage) {
    if (strengthPercentage >= 0.8) {
      return Colors.green;
    } else if (strengthPercentage >= 0.5) {
      return Colors.yellow;
    } else if (strengthPercentage >= 0.3) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
