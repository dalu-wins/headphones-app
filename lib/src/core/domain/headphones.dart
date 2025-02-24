import 'package:headphones_app/src/features/battery_indicator/domain/power_status.dart';
import 'package:headphones_app/src/features/equalizer/domain/equalizer_mode.dart';
import 'package:headphones_app/src/features/noise_cancelling/domain/noise_status.dart';

class Headphones {
  String name;
  int battery;
  String assetLocation;

  PowerStatus powerStatus;
  NoiseCancellingStatus noiseCancellingStatus;

  int ncStrength;
  int ptStrength;

  EqualizerMode equalizerMode;
  bool boostBass;

  Headphones(
    this.name,
    this.battery,
    this.assetLocation,
    this.powerStatus,
    this.noiseCancellingStatus,
    this.ncStrength,
    this.ptStrength,
    this.equalizerMode,
    this.boostBass,
  );

  void powerOff() {
    powerStatus = PowerStatus.off;
  }

  void powerOn() {
    powerStatus = PowerStatus.on;
  }
}

// TODO: Only for developing / debugging, remove later!
final Headphones airPodsMax = Headphones(
  "Apple AirPods Max",
  80,
  "assets/models/apple_airpods_max.glb",
  PowerStatus.on,
  NoiseCancellingStatus.on,
  75,
  25,
  EqualizerMode.rock,
  false,
);
