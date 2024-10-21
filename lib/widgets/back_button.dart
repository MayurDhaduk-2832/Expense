import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../res/strings.dart';

class CommonBackButton extends StatelessWidget {
  VoidCallback? onTap;
  Color? color;
  CommonBackButton({
    this.onTap,
    this.color
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          Navigator.pop(context);
          if(onTap != null){
          onTap!();
          }
        },
        child: Image.asset(StringRes.backIcon, height: SizerUtil.deviceType == DeviceType.tablet ? 25 : 16,color: color),);
  }
}
