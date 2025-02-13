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

  Headphones(
    this.name,
    this.battery,
    this.assetLocation,
    this.powerStatus,
    this.noiseCancellingStatus,
    this.ncStrength,
    this.ptStrength,
  );

  void powerOff() {
    powerStatus = PowerStatus.off;
  }

  void powerOn() {
    powerStatus = PowerStatus.on;
  }
}
