import 'package:flutter/material.dart';
import 'package:range_visualizer_app/model/range_model.dart';
import 'package:range_visualizer_app/util/color.dart';

class RangeBar extends StatelessWidget {
  final List<RangeModel> ranges;
  const RangeBar({super.key, required this.ranges});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: CustomPaint(
        painter: _RangeBarPainter(ranges: ranges),
        size: const Size(double.infinity, 32),
      ),
    );
  }
}

class _RangeBarPainter extends CustomPainter {
  final List<RangeModel> ranges;

  _RangeBarPainter({required this.ranges});

  @override
  void paint(Canvas canvas, Size size) {
    if (ranges.isEmpty) return;

    final paint = Paint()..style = PaintingStyle.fill;

    final rMin = ranges.first.start;
    final rMax = ranges.last.end;
    final totalRange = rMax - rMin + 1;

    double startX = 0;

    for (final range in ranges) {
      final rangeWidth = range.end - range.start + 1;
      final widthFraction = rangeWidth / totalRange;
      final barWidth = widthFraction * size.width;

      paint.color = ColorUtils.hex2Color(range.color);
      canvas.drawRect(Rect.fromLTWH(startX, 0, barWidth, size.height), paint);

      startX += barWidth;
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
