import 'package:flutter/material.dart';
import 'package:headphones_app/src/core/domain/headphones.dart';
import 'package:headphones_app/src/features/noise_cancelling/domain/noise_status.dart';
import 'package:headphones_app/src/features/equalizer/presentation/equalizer_widget.dart';
import 'package:headphones_app/src/features/noise_cancelling/presentation/noise_cancelling_widget.dart';
import 'package:headphones_app/src/overview/presentation/widgets/single_settings_widget.dart';

class SettingsColumn extends StatelessWidget {
  final Headphones headphones;
  final Function(Set<NoiseCancellingStatus>) setNoiseCancellingStatus;
  final Function(double) setNoiseCancellingStrength;
  final Function(double) setPassThroughStrength;

  const SettingsColumn({
    super.key,
    required this.headphones,
    required this.setNoiseCancellingStatus,
    required this.setPassThroughStrength,
    required this.setNoiseCancellingStrength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          SettingsWidget(
            settingName: "Ambient Sound",
            settingsWidget: NoiseCancellingWidget(
              headphones: headphones,
              setNoiseCancellingStatus: setNoiseCancellingStatus,
            ),
          ),
          SettingsWidget(
            settingName: "Equalizer",
            settingsWidget: Column(
              spacing: 8,
              children: [
                EqualizerWidget(
                  headphones: headphones,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
