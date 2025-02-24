import 'package:flutter/material.dart';
import 'package:headphones_app/src/core/domain/headphones.dart';
import 'package:headphones_app/src/features/noise_cancelling/domain/noise_status.dart';
import 'package:headphones_app/src/overview/presentation/widgets/info_widget.dart';
import 'package:headphones_app/src/overview/presentation/widgets/settings_column_widget.dart';
import 'package:o3d/o3d.dart';

class OverviewCompact extends StatelessWidget {
  final O3DController controller;
  final CameraOrbit cameraOrbit;
  final Headphones headphones;

  final Function onPowerOff;
  final Function(Set<NoiseCancellingStatus>) setNoiseCancellingStatus;
  final Function(double) setPassThroughLevel;
  final Function(double) setNoiseCancellingLevel;

  const OverviewCompact({
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
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.paddingOf(context),
        child: Column(
          children: [
            InfoWidget(
              controller: controller,
              cameraOrbit: cameraOrbit,
              headphones: headphones,
              onPowerOff: onPowerOff,
            ),
            SettingsColumn(
              headphones: headphones,
              setNoiseCancellingStatus: setNoiseCancellingStatus,
              setPassThroughStrength: setPassThroughLevel,
              setNoiseCancellingStrength: setNoiseCancellingLevel,
            ),
          ],
        ),
      ),
    );
  }
}
