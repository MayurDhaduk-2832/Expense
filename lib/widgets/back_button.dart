import 'package:expense_tracker/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;

  const CommonBackButton({super.key, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.pop(context);
        if (onTap != null) {
          onTap!();
        }
      },
      child: Image.asset(
        StringRes.backIcon,
        height: Device.screenType == ScreenType.tablet ? 25 : 16,
        color: color,
      ),
    );
  }
}
