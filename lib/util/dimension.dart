import 'package:range_visualizer_app/model/indicator_pos.dart';
import 'package:range_visualizer_app/model/range_model.dart';
import 'package:range_visualizer_app/model/range_segment.dart';

class DimensionUtils {
  static List<RangeSegment> computeSegments(
    List<RangeModel> ranges,
    double maxWidth,
  ) {
    final rMin = ranges.first.start;
    final rMax = ranges.last.end;
    final totalRange = rMax - rMin + 1;

    return ranges.map((range) {
      final rangeWidth = range.end - range.start + 1;
      final widthFraction = rangeWidth / totalRange;
      final barWidth = widthFraction * maxWidth;

      return RangeSegment(
        start: range.start,
        end: range.end,
        width: barWidth,
        color: range.color,
      );
    }).toList();
  }

  static IndicatorPos calculatePosition({
    required List<RangeModel> ranges,
    required int value,
    required double maxWidth,
  }) {
    final rMin = ranges.first.start;
    final rMax = ranges.last.end;
    final totalRange = rMax - rMin + 1;

    double dx = 0;
    String meaning = '';
    String color = '#000000';

    if (value < rMin) {
      meaning = 'Underflow';
      dx = 0;
    } else if (value > rMax) {
      meaning = 'Overflow';
      dx = maxWidth;
    } else {
      for (final range in ranges) {
        final beforeWidth = ranges
            .takeWhile((r) => r.end < range.start)
            .fold(0.0, (sum, r) =>
                sum + ((r.end - r.start + 1) / totalRange) * maxWidth);

        if (value >= range.start && value <= range.end) {
          final relative =
              (value - range.start) / (range.end - range.start + 1);
          dx = beforeWidth +
              relative *
                  ((range.end - range.start + 1) / totalRange) *
                  maxWidth;

          meaning = range.meaning;
          color = range.color;
          break;
        }
      }
    }

    return IndicatorPos(dx: dx, label: meaning, color: color);
  }
}
