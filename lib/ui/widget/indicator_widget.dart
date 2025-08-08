import 'package:flutter/cupertino.dart';
import 'package:range_visualizer_app/model/range_model.dart';
import 'package:range_visualizer_app/util/color.dart';
import 'package:range_visualizer_app/util/dimension.dart';

class IndicatorWidget extends StatelessWidget {
  final List<RangeModel> ranges;
  final int inputValue;

  const IndicatorWidget({
    super.key,
    required this.ranges,
    required this.inputValue,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pos = DimensionUtils.calculatePosition(
          ranges: ranges,
          value: inputValue,
          maxWidth: constraints.maxWidth,
        );

        return SizedBox(
          height: 48,
          width: constraints.maxWidth,
          child: Stack(
            children: [
              Positioned(
                left: pos.dx - 10,
                top: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.arrow_up,
                      size: 15,
                      color: ColorUtils.hex2Color(pos.color),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      pos.label,
                      style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                        fontSize: 10,
                        color: CupertinoColors.extraLightBackgroundGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}