import 'package:flutter/material.dart';

class FrequencyGraph extends StatelessWidget {
  final List<double> frequencies;
  final List<double> levels;

  const FrequencyGraph({
    super.key,
    required this.frequencies,
    required this.levels,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: CustomPaint(
              size: Size(double.infinity, 200),
              painter: FrequencyGraphPainter(
                frequencies,
                levels,
                Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FrequencyGraphPainter extends CustomPainter {
  final List<double> frequencies;
  final List<double> levels;
  final Color barColor;

  FrequencyGraphPainter(
    this.frequencies,
    this.levels,
    this.barColor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill;

    textPainter(String text, Offset offset) {
      final tp = TextPainter(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, offset);
    }

    double barWidth = size.width / frequencies.length;
    for (int i = 0; i < frequencies.length; i++) {
      double barHeight = (levels[i] + 10) / 20 * size.height;
      double x = i * barWidth;
      double y = size.height - barHeight;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth * 0.8, barHeight),
        Radius.circular(8),
      );
      canvas.drawRRect(rect, paint);

      textPainter("${frequencies[i].toInt()} Hz", Offset(x, size.height + 5));
      textPainter("${levels[i].toInt()} dB", Offset(x, y - 15));
    }
  }

  @override
  bool shouldRepaint(FrequencyGraphPainter oldDelegate) {
    return oldDelegate.levels.toString() != levels.toString();
  }
}
