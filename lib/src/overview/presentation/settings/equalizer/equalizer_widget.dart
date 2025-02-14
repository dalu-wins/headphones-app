import 'package:flutter/material.dart';

class EqualizerWidget extends StatefulWidget {
  const EqualizerWidget({super.key});

  @override
  EqualizerWidgetState createState() => EqualizerWidgetState();
}

class EqualizerWidgetState extends State<EqualizerWidget> {
  final List<double> _frequencies = [60, 230, 910, 3600, 14000];
  final List<double> _levels = [0, 0, 0, 0, 0];
  final List<String> _presets = [
    "Flat",
    "Rock",
    "Pop",
    "Jazz",
    "Classical",
    "Custom"
  ];
  String _selectedPreset = "Flat";
  bool _boostedBass = false;

  void _applyPreset(String preset) {
    setState(() {
      _selectedPreset = preset;
      switch (preset) {
        case "Rock":
          _levels.setAll(0, [3, 5, -2, 4, 1]);
          break;
        case "Pop":
          _levels.setAll(0, [5, 3, 1, -1, -2]);
          break;
        case "Jazz":
          _levels.setAll(0, [-2, 3, 5, 2, 1]);
          break;
        case "Classical":
          _levels.setAll(0, [4, -1, -3, 5, 3]);
          break;
        case "Custom":
          _levels.setAll(0, [-4, -2, 0, 2, 4]);
          break;
        default:
          _levels.fillRange(0, _levels.length, 0);
      }
    });
  }

  void _toggleBassBoost(bool value) {
    setState(() {
      _boostedBass = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _presets.map((preset) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text(preset),
                  selected: _selectedPreset == preset,
                  onSelected: (bool selected) {
                    if (selected) {
                      _applyPreset(preset);
                    }
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        // Expanded(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: List.generate(
        //       _frequencies.length,
        //       (index) {
        //         return Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text("${_frequencies[index].toInt()} Hz",
        //                 style: const TextStyle(fontWeight: FontWeight.bold)),
        //             Expanded(
        //               child: RotatedBox(
        //                 quarterTurns: -1,
        //                 child: Slider(
        //                   min: -10,
        //                   max: 10,
        //                   value: _levels[index],
        //                   onChanged: (value) {
        //                     setState(() {
        //                       _levels[index] = value;
        //                     });
        //                   },
        //                 ),
        //               ),
        //             ),
        //             Text("${_levels[index].toInt()} dB"),
        //           ],
        //         );
        //       },
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Boost Bass"),
            Switch(
              value: _boostedBass,
              onChanged: _toggleBassBoost,
            ),
          ],
        )
      ],
    );
  }
}
