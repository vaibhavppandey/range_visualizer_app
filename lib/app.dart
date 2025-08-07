
import 'package:flutter/material.dart';

class RangeVizualizerApp extends StatelessWidget {
  const RangeVizualizerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: Placeholder(),
    );
  }
}