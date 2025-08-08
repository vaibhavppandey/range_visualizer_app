import 'package:range_visualizer_app/logic/notifiers.dart';
import 'package:range_visualizer_app/service/api.dart';

class RangeLoader {
  static Future<void> loadRanges() async {
    Notifiers.loading.value = true;
    Notifiers.error.value = null;

    try {
      final ranges = await APIService.getRanges();
      Notifiers.ranges.value = ranges;
    } catch (e) {
      Notifiers.error.value = e.toString();
    } finally {
      Notifiers.loading.value = false;
    }
  }
}
