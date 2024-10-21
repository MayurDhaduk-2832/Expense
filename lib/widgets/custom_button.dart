import 'package:expense_tracker/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class CommonButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  Color? textColor;
  Color? buttonColor;

  CommonButton(
      {Key? key,
      required this.onTap,
      required this.title,
      this.buttonColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
        onTap();
      },
      child: Container(
        height: SizerUtil.deviceType == DeviceType.tablet ? 90 : 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: buttonColor ?? AppColors.buttonColor, borderRadius: BorderRadius.circular(16),),
        child: Text(title,style: TextStyle(
          color: textColor ?? AppColors.whiteTextColor,
          fontSize:SizerUtil.deviceType == DeviceType.tablet ? 12.sp : 14.sp,
          fontWeight: FontWeight.w500
        ),),
      ),
    );
  }
}
