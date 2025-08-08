import 'dart:ui';

class ColorUtils {
  static Color hex2Color(String hex) {
    final clean = hex.replaceAll('#', '');
    return Color(int.parse('FF$clean', radix: 16));
  }
}