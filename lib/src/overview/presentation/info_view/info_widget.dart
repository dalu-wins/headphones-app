import 'package:flutter/material.dart';
import 'package:headphones_app/src/core/data/headphones/headphones.dart';
import 'package:headphones_app/src/overview/presentation/info_view/battery/battery_indicator.dart';
import 'package:o3d/o3d.dart';

class InfoWidget extends StatelessWidget {
  final O3DController controller;
  final CameraOrbit cameraOrbit;
  final Headphones headphones;
  final double height;
  final Function onPowerOff;
  final bool centralized;

  const InfoWidget({
    super.key,
    required this.controller,
    required this.cameraOrbit,
    required this.headphones,
    required this.onPowerOff,
    this.height = 400, // Default height
    this.centralized = false,
  });

  void _reset3DModel() {
    controller.cameraOrbit(
      cameraOrbit.theta,
      cameraOrbit.phi,
      cameraOrbit.radius,
    );
  }

  // Show confirmation dialog before powering off
  Future<void> _showPowerOffDialog(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Power Off'),
          content: Text('Are you sure you want to power off the headphones?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog and return false (cancel)
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog and return true (confirm)
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );

    // If confirmed, toggle the power and reset the 3D model
    if (confirmed == true) {
      onPowerOff();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: centralized
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
              children: [
                if (centralized)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      headphones.name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                IconButton(
                  onPressed: () => _showPowerOffDialog(context),
                  icon: Icon(Icons.power_settings_new),
                ),
              ],
            ),
            Expanded(
              // O3D will take all remaining space
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: O3D(
                  controller: controller,
                  src: headphones.assetLocation,
                  disableZoom: true,
                  disableTap: true,
                  disablePan: true,
                  cameraOrbit: cameraOrbit,
                  minCameraOrbit: "auto 30deg 100",
                  maxCameraOrbit: "auto 150deg 100",
                  exposure: 1,
                  interactionPrompt: InteractionPrompt.none,
                ),
              ),
            ),
            if (!centralized)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  headphones.name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 8), // Spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BatteryIndicator(
                  batteryPercentage: headphones.battery,
                  powerStatus: headphones.powerStatus,
                ),
                const SizedBox(width: 8), // Spacing
                OutlinedButton(
                  onPressed: _reset3DModel,
                  child: const Icon(Icons.rotate_left),
                ),
              ],
            ),
            if (centralized) SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
