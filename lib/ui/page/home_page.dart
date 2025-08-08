import 'package:flutter/cupertino.dart';
import 'package:range_visualizer_app/logic/notifiers.dart';
import 'package:range_visualizer_app/logic/range_loader.dart';
import 'package:range_visualizer_app/ui/widget/loading_widget.dart';
import 'package:range_visualizer_app/ui/widget/range_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    RangeLoader.loadRanges();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Range Visualizer')),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
          valueListenable: Notifiers.loading,
          builder: (context, loading, child) {
            if (loading) {
              return const Center(child: LoadingWidget());
            } else {
              return child ?? SizedBox.shrink();
            }
          },
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoTextField(
                  padding: const EdgeInsets.all(16.0),
                  keyboardType: TextInputType.number,
                  placeholder: 'Enter a range',
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder(
                  valueListenable: Notifiers.ranges,
                  builder: (context, ranges, child) => RangeBar(ranges: ranges),
                ),
              ],
            )
        ),
      ),
    );
  }
}
