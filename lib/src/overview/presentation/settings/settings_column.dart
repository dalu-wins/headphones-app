import 'package:flutter/material.dart';
import 'package:headphones_app/src/core/data/headphones/headphones.dart';
import 'package:headphones_app/src/core/data/headphones/noise_status.dart';
import 'package:headphones_app/src/overview/presentation/settings/equalizer/equalizer_widget.dart';
import 'package:headphones_app/src/overview/presentation/settings/noise_cancelling/nc_segmented_button.dart';
import 'package:headphones_app/src/overview/presentation/settings/noise_cancelling/noise_cancelling_bar.dart';
import 'package:headphones_app/src/overview/presentation/settings/noise_cancelling/pass_through_bar.dart';
import 'package:headphones_app/src/overview/presentation/settings/settings_widget.dart';

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
            isExpanded: true,
            settingsWidget: Column(
              spacing: 8,
              children: [
                NCSegmentedButton(
                  noiseCancellingStatus: headphones.noiseCancellingStatus,
                  onSelectionChanged: setNoiseCancellingStatus,
                ),
                NoiseCancellingBar(
                  noiseLevel: headphones.ncStrength.toDouble(), // Bind to state
                  onNoiseLevelChanged: setNoiseCancellingStrength,
                ),
                PassThroughBar(
                  passLevel: headphones.ptStrength.toDouble(), // Bind to state
                  onPassLevelChanged: setPassThroughStrength,
                ),
              ],
            ),
          ),
          SettingsWidget(
            settingName: "Equalizer",
            isExpanded: true,
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
