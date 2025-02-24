import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  final String settingName;
  final Widget settingsWidget;
  final bool isExpanded;

  const SettingsWidget({
    super.key,
    required this.settingName,
    required this.settingsWidget,
    this.isExpanded = false,
  });

  @override
  SettingsWidgetState createState() => SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {
  late bool _isExpanded; // Track expanded/collapsed state

  @override
  void initState() {
    super.initState();
    // Set the initial expanded state based on the passed parameter
    _isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
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
                IconButton(
                  icon:
                      Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded; // Toggle expand state
                    });
                  },
                ),
              ],
            ),
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.settingsWidget,
              ),
          ],
        ),
      ),
    );
  }
}
