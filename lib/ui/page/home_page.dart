import 'package:flutter/cupertino.dart';
import 'package:range_visualizer_app/logic/notifiers.dart';
import 'package:range_visualizer_app/logic/range_loader.dart';
import 'package:range_visualizer_app/model/range_model.dart';
import 'package:range_visualizer_app/ui/widget/error_widget.dart';
import 'package:range_visualizer_app/ui/widget/indicator_widget.dart';
import 'package:range_visualizer_app/ui/widget/input_field.dart';
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
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Range Visualizer'),
        trailing: CupertinoButton(
          onPressed: RangeLoader.loadRanges,
          child: Icon(CupertinoIcons.refresh),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder<bool>(
          valueListenable: Notifiers.loading,
          builder: (context, loading, _) {
            if (loading) return const Center(child: LoadingWidget());

            return ValueListenableBuilder<String?>(
              valueListenable: Notifiers.error,
              builder: (context, error, _) {
                if (error != null) {
                  return const Center(child: ErrorRetryWidget());
                }

                return ValueListenableBuilder<List<RangeModel>>(
                  valueListenable: Notifiers.ranges,
                  builder: (context, ranges, _) {
                    return ValueListenableBuilder<int?>(
                      valueListenable: Notifiers.input,
                      builder: (context, input, _) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const InputField(),
                            const SizedBox(height: 20),
                            RangeBar(ranges: ranges),
                            const SizedBox(height: 12),
                            if (input != null)
                              if (!isKeyboardVisible)
                                AnimatedOpacity(
                                  opacity: isKeyboardVisible ? 0 : 1,
                                  duration: const Duration(milliseconds: 300),
                                  child: IndicatorWidget(
                                    ranges: ranges,
                                    inputValue: input,
                                  ),
                                ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
