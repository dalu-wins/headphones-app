import 'package:flutter/material.dart';

class StrengthChip extends StatelessWidget {
  final String chipName;
  final int strength;

  const StrengthChip({
    super.key,
    required this.chipName,
    required this.strength,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(chipName),
          Text("${strength.toString()}%"),
        ],
      ),
      shape: StadiumBorder(),
    );
  }
}
