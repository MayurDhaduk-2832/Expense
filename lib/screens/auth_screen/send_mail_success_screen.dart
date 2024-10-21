import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/size_utils.dart';
import '../../res/app_colors.dart';
import '../../res/strings.dart';

class SendMailSuccessScreen extends StatelessWidget {
  const SendMailSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 12.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Image.asset(StringRes.sendMailIcon),
            ),
          ),
          Text(
            "Your email is on the way",
            style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
                fontSize: SizeUtil.f18),
          ),
          SizedBox(height: 3.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              "Check your email ${ModalRoute.of(context)!.settings.arguments} and follow the instructions to reset your password",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeUtil.f12),
            ),
          ),
          SizedBox(height: 5.h),
          const Spacer(),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.3.w),
            child: CommonButton(onTap: (){
              Navigator.pop(context);
            }, title: "Back to Login"),
          ),
          SizedBox(height: 4.h),
          
        ],
      ),
    );
  }
}
