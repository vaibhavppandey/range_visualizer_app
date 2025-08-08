import 'package:flutter/cupertino.dart';
import 'package:range_visualizer_app/model/range_model.dart';
import 'package:range_visualizer_app/model/range_segment.dart';
import 'package:range_visualizer_app/util/color.dart';
import 'package:range_visualizer_app/util/dimension.dart';

class RangeBar extends StatelessWidget {
  final List<RangeModel> ranges;
  const RangeBar({super.key, required this.ranges});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ranges.isEmpty) return const SizedBox.shrink();

        final segments = DimensionUtils.computeSegments(
          ranges,
          constraints.maxWidth,
        );

        List<Widget> topLabels = [];
        List<Widget> bottomLabels = [];
        buildLabels(segments, context, topLabels, bottomLabels);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: topLabels),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: CustomPaint(
                painter: _RangeBarPainter(segments: segments),
                size: Size(constraints.maxWidth, 32),
              ),
            ),
            Row(children: bottomLabels),
          ],
        );
      },
    );
  }

  void buildLabels(
    List<RangeSegment> segments,
    BuildContext context,
    List<Widget> topLabels,
    List<Widget> bottomLabels,
  ) {
    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];
      final label = SizedBox(
        width: segment.width,
        child: Text(
          segment.start.toString(),
          textAlign: TextAlign.left,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: 10,
            color: CupertinoColors.extraLightBackgroundGray,
          ),
        ),
      );

      if (i % 2 == 0) {
        topLabels.add(label);
        bottomLabels.add(SizedBox(width: segment.width));
      } else {
        topLabels.add(SizedBox(width: segment.width));
        bottomLabels.add(label);
      }
    }
  }
}

class _RangeBarPainter extends CustomPainter {
  final List<RangeSegment> segments;

  _RangeBarPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    if (segments.isEmpty) return;

    final paint = Paint()..style = PaintingStyle.fill;

    double startX = 0;

    for (final segment in segments) {
      paint.color = ColorUtils.hex2Color(segment.color);
      canvas.drawRect(
        Rect.fromLTWH(startX, 0, segment.width, size.height),
        paint,
      );
      startX += segment.width;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
