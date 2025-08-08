import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:range_visualizer_app/ui/page/home_page.dart';

class RangeVizualizerApp extends StatelessWidget {
  const RangeVizualizerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(title: 'Range Visualizer', home: HomePage());
  }
}
