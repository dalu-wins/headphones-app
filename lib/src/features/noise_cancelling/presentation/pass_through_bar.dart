import 'package:flutter/material.dart';

class PassThroughBar extends StatelessWidget {
  final double passLevel;
  final Function(double) onPassLevelChanged;

  const PassThroughBar({
    super.key,
    required this.passLevel,
    required this.onPassLevelChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 50, child: Text("PT")),
        Expanded(
          child: Slider(
            value: passLevel,
            min: 0,
            max: 100,
            divisions: 4, // 25% step increments
            onChanged: onPassLevelChanged,
          ),
        ),
      ],
    );
  }
}
