import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:headphones_app/src/core/domain/headphones.dart';
import 'package:headphones_app/src/features/noise_cancelling/domain/noise_status.dart';
import 'package:headphones_app/src/features/music_player/presentation/music_bar.dart';
import 'package:headphones_app/src/overview/presentation/overview_compact.dart';
import 'package:headphones_app/src/overview/presentation/overview_large.dart';
import 'package:o3d/o3d.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  final O3DController controller = O3DController();
  final CameraOrbit cameraOrbit = CameraOrbit(50, 90, 100);
  final Headphones headphones = airPodsMax;

  void _setUiStyle() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Update the system UI based on the current brightness
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _setUiStyle();

    return Scaffold(
      bottomNavigationBar: MusicBar(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 840) {
            return OverviewLarge(
              headphones: headphones,
              setNoiseCancellingLevel: setNoiseCancellingLevel,
              setPassThroughLevel: setPassThroughLevel,
              setNoiseCancellingStatus: setNoiseCancellingStatus,
              onPowerOff: onPowerOff,
              controller: controller,
              cameraOrbit: cameraOrbit,
            );
          } else {
            return OverviewCompact(
              headphones: headphones,
              setNoiseCancellingLevel: setNoiseCancellingLevel,
              setPassThroughLevel: setPassThroughLevel,
              setNoiseCancellingStatus: setNoiseCancellingStatus,
              onPowerOff: onPowerOff,
              controller: controller,
              cameraOrbit: cameraOrbit,
            );
          }
        },
      ),
    );
  }

  void onPowerOff() {
    setState(() {
      headphones.powerOff();
    });
  }

  void setNoiseCancellingStatus(Set<NoiseCancellingStatus> newStatus) {
    setState(() {
      headphones.noiseCancellingStatus = newStatus.first;
    });
  }

  void setPassThroughLevel(double newLevel) {
    setState(() {
      headphones.ptStrength = newLevel.toInt();
    });
  }

  void setNoiseCancellingLevel(double newLevel) {
    setState(() {
      headphones.ncStrength = newLevel.toInt();
    });
  }
}
