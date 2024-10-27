import 'package:expense_tracker/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color? textColor;
  final Color? buttonColor;

  const CommonButton({
    super.key,
    required this.onTap,
    required this.title,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        onTap();
      },
      child: Container(
        height: Device.screenType == ScreenType.tablet ? 90 : 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.buttonColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: textColor ?? AppColors.whiteTextColor,
              fontSize: Device.screenType == ScreenType.tablet ? 12.sp : 14.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
