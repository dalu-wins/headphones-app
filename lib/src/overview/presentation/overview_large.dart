import 'package:flutter/material.dart';
import 'package:headphones_app/src/core/data/headphones.dart';
import 'package:headphones_app/src/core/data/noise_status.dart';
import 'package:headphones_app/src/overview/presentation/info_view/info_widget.dart';
import 'package:headphones_app/src/overview/presentation/settings/settings_column.dart';
import 'package:o3d/o3d.dart';

class OverviewLarge extends StatelessWidget {
  final O3DController controller;
  final CameraOrbit cameraOrbit;
  final Headphones headphones;

  final Function onPowerOff;
  final Function(Set<NoiseCancellingStatus>) setNoiseCancellingStatus;
  final Function(double) setPassThroughLevel;
  final Function(double) setNoiseCancellingLevel;

  const OverviewLarge({
    super.key,
    required this.setNoiseCancellingStatus,
    required this.setPassThroughLevel,
    required this.setNoiseCancellingLevel,
    required this.controller,
    required this.cameraOrbit,
    required this.headphones,
    required this.onPowerOff,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.paddingOf(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column - InfoWidget (Takes 1 part of available space)
          Expanded(
            flex: 1,
            child: InfoWidget(
              height: double.infinity,
              controller: controller,
              cameraOrbit: cameraOrbit,
              headphones: headphones,
              onPowerOff: onPowerOff,
              centralized: true,
            ),
          ),
          // Right Column - Scrollable Settings (Takes 1 part of available space)
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: SettingsColumn(
                headphones: headphones,
                setNoiseCancellingStatus: setNoiseCancellingStatus,
                setPassThroughStrength: setPassThroughLevel,
                setNoiseCancellingStrength: setNoiseCancellingLevel,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
