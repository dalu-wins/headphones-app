import 'package:flutter/material.dart';
import 'package:headphones_app/src/core/data/noise_status.dart';

class NCSegmentedButton extends StatelessWidget {
  final NoiseCancellingStatus noiseCancellingStatus;
  final Function(Set<NoiseCancellingStatus>) onSelectionChanged;

  const NCSegmentedButton({
    super.key,
    required this.noiseCancellingStatus,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<NoiseCancellingStatus>(
        segments: const <ButtonSegment<NoiseCancellingStatus>>[
          ButtonSegment<NoiseCancellingStatus>(
            value: NoiseCancellingStatus.passthrough,
            label: Text('PT'),
            icon: Icon(Icons.noise_aware),
          ),
          ButtonSegment<NoiseCancellingStatus>(
            value: NoiseCancellingStatus.off,
            label: Text('OFF'),
            icon: Icon(Icons.radio_button_unchecked),
          ),
          ButtonSegment<NoiseCancellingStatus>(
            value: NoiseCancellingStatus.on,
            label: Text('ANC'),
            icon: Icon(Icons.noise_control_off),
          ),
        ],
        selected: <NoiseCancellingStatus>{noiseCancellingStatus},
        onSelectionChanged: onSelectionChanged,
      ),
    );
  }
}
