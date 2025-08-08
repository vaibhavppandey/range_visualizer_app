import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Fetching Ranges",
          style: CupertinoTheme.of(context).textTheme.navTitleTextStyle.copyWith(
            color: CupertinoColors.extraLightBackgroundGray,
          ),
        ),
        const SizedBox(height: 8.0),
        CupertinoActivityIndicator(
          color: CupertinoColors.inactiveGray,
          radius: 12.0,
        ),
      ],
    );
  }
}
