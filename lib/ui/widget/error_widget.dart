import 'package:flutter/cupertino.dart';
import 'package:range_visualizer_app/logic/range_loader.dart';

class ErrorRetryWidget extends StatelessWidget {
  const ErrorRetryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Something went wrong, try again",
          style: CupertinoTheme.of(context).textTheme.navTitleTextStyle
              .copyWith(color: CupertinoColors.destructiveRed),
        ),
        const SizedBox(height: 8.0),
        CupertinoButton(
          onPressed: RangeLoader.loadRanges,
          child: const Icon(
            CupertinoIcons.refresh,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ],
    );
  }
}
