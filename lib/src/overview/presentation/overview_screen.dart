import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:headphones_app/src/core/data/headphones.dart';
import 'package:headphones_app/src/core/data/noise_status.dart';
import 'package:headphones_app/src/core/data/power_status.dart';
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
  final Headphones headphones = Headphones(
    "Apple AirPods Max",
    80,
    "assets/models/apple_airpods_max.glb",
    PowerStatus.on,
    NoiseCancellingStatus.on,
    50,
    50,
  );

  void _updateSystemUI() {
    Brightness brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark, // Adjust icons
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark, // Nav icons
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateSystemUI(); // Update UI on theme change
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _updateSystemUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
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
