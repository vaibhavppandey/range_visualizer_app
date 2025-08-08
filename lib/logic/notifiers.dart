import 'package:flutter/cupertino.dart';
import 'package:range_visualizer_app/model/range_model.dart';

class Notifiers {
  Notifiers._();

  static final ValueNotifier<String> input = ValueNotifier<String>('');
  static final ValueNotifier<List<RangeModel>> range = ValueNotifier<List<RangeModel>>([]);
  static final ValueNotifier<bool> loading = ValueNotifier<bool>(true);
  static final ValueNotifier<String?> error = ValueNotifier<String?>(null);
  static final ValueNotifier<bool> success = ValueNotifier<bool>(true);
}