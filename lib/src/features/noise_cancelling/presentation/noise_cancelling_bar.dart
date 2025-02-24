import 'package:flutter/material.dart';

class NoiseCancellingBar extends StatelessWidget {
  final double noiseLevel;
  final Function(double) onNoiseLevelChanged;

  const NoiseCancellingBar({
    super.key,
    required this.noiseLevel,
    required this.onNoiseLevelChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 50, child: Text("ANC")),
        Expanded(
          child: Slider(
            value: noiseLevel,
            min: 0,
            max: 100,
            divisions: 4, // 25% step increments
            onChanged: onNoiseLevelChanged,
          ),
        ),
      ],
    );
  }
}
