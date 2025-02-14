import 'package:flutter/material.dart';
import 'package:headphones_app/src/core/data/headphones/power_status.dart';

class BatteryIndicator extends StatelessWidget {
  final int batteryPercentage;
  final PowerStatus powerStatus;

  const BatteryIndicator({
    super.key,
    required this.batteryPercentage,
    required this.powerStatus,
  });

  Color getPercentageColor() {
    if (powerStatus == PowerStatus.off) {
      return Colors.grey;
    }

    if (batteryPercentage < 20) {
      return Colors.red;
    } else if (batteryPercentage < 50) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  String getPercentageText() {
    if (powerStatus == PowerStatus.off) {
      return "OFF";
    } else {
      return "$batteryPercentage%";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: getPercentageColor(),
              shape: BoxShape.circle,
            ),
          ),
          Text(getPercentageText()),
        ],
      ),
      shape: StadiumBorder(),
    );
  }
}
