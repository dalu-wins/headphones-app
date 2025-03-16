import 'package:flutter/material.dart';
import 'package:headphones_app/src/core/domain/headphones.dart';
import 'package:headphones_app/src/features/noise_cancelling/domain/noise_status.dart';
import 'package:headphones_app/src/features/noise_cancelling/presentation/nc_segmented_button.dart';
import 'package:headphones_app/src/features/noise_cancelling/presentation/strength_chip.dart';

class NoiseCancellingWidget extends StatelessWidget {
  final Headphones headphones;
  final Function(Set<NoiseCancellingStatus>) setNoiseCancellingStatus;

  const NoiseCancellingWidget({
    super.key,
    required this.headphones,
    required this.setNoiseCancellingStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        NCSegmentedButton(
          noiseCancellingStatus: headphones.noiseCancellingStatus,
          onSelectionChanged: setNoiseCancellingStatus,
        ),
      ],
    );
  }
}
