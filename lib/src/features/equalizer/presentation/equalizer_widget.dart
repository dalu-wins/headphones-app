import 'package:flutter/material.dart';
import 'package:headphones_app/src/features/equalizer/domain/equalizer_mode.dart';
import 'package:headphones_app/src/core/domain/headphones.dart';
import 'package:headphones_app/src/features/equalizer/presentation/frequency_graph.dart';

class EqualizerWidget extends StatefulWidget {
  final Headphones headphones;

  const EqualizerWidget({
    super.key,
    required this.headphones,
  });

  @override
  EqualizerWidgetState createState() => EqualizerWidgetState();
}

class EqualizerWidgetState extends State<EqualizerWidget> {
  final List<double> _frequencies = [60, 230, 910, 3600, 14000];
  List<double> _levels = [
    0,
    0,
    0,
    0,
    0
  ]; // Remove `final` to allow reassignment

  // Get all enum values
  List<EqualizerMode> modes = EqualizerMode.values;

  void _toggleBassBoost(bool value) {
    setState(() {
      widget.headphones.boostBass = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _levels =
        List.from(widget.headphones.equalizerMode.levels); // Copy the list
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        SizedBox(
          height: 150,
          child: FrequencyGraph(frequencies: _frequencies, levels: _levels),
        ),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: modes.map(
              (preset) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(preset.name),
                    selected: widget.headphones.equalizerMode == preset,
                    onSelected: (bool selected) {
                      if (selected) {
                        setState(() {
                          widget.headphones.equalizerMode = preset;
                          _levels = List.from(preset.levels); // Copy the list
                        });
                      }
                    },
                  ),
                );
              },
            ).toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Boost Bass"),
            Switch(
              value: widget.headphones.boostBass,
              onChanged: _toggleBassBoost,
            ),
          ],
        )
      ],
    );
  }
}
