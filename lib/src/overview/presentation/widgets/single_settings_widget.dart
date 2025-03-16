import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  final String settingName;
  final Widget settingsWidget;

  const SettingsWidget({
    super.key,
    required this.settingName,
    required this.settingsWidget,
  });

  @override
  SettingsWidgetState createState() => SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Space out elements
              children: [
                Text(
                  widget.settingName,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            widget.settingsWidget,
          ],
        ),
      ),
    );
  }
}
