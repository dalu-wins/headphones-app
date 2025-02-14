import 'package:headphones_app/src/core/data/equalizer_mode.dart';
import 'package:headphones_app/src/core/data/noise_status.dart';
import 'package:headphones_app/src/core/data/power_status.dart';

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
  NoiseCancellingStatus.off,
  50,
  50,
  EqualizerMode.flat,
  false,
);
