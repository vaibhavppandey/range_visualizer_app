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
}
