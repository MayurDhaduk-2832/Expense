import 'package:expense_tracker/widgets/back_button.dart';
import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/size_utils.dart';
import '../../res/app_colors.dart';
import '../../res/strings.dart';
import '../../widgets/otp_text_field.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.33.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 7.h,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CommonBackButton()
                ),
                Text(
                  StringRes.verification,
                  style: StringRes.appBarTitle,
                )
              ],
            ),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringRes.enterYourVerificationCode,
                  style: TextStyle(
                      color: const Color(0xFF0D0E0F),
                      fontWeight: FontWeight.w500,
                      fontSize: SizerUtil.deviceType == DeviceType.tablet ? 20.sp : 27.sp),
                ),
                SizedBox(height:MediaQuery.of(context).viewInsets.bottom > 1 ? 3.h : 8.h),
                OtpTextField(controller: _otpController),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom > 1 ? 2.h : 8.h),
                Text(
                  "04:29",
                  style: TextStyle(
                      color: AppColors.buttonColor,
                      fontWeight: FontWeight.w600,
                      fontSize:SizeUtil.f12),
                ),
                SizedBox(height: 1.8.h),
                RichText(
                  text: TextSpan(
                      text: "We send verification code to your email ",
                      style: TextStyle(
                          color: Color(0xFF292B2D),
                          fontWeight: FontWeight.w500,
                          fontSize: SizeUtil.f12),
                      children: [
                        TextSpan(
                          text: "brajaoma*****@gmail.com",
                          recognizer: TapGestureRecognizer()..onTap = (){
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/login");
                          },
                          style: TextStyle(
                              color: AppColors.buttonColor,
                              fontWeight: FontWeight.w500,
                              fontSize:SizeUtil.f12),
                        ),
                        TextSpan(
                          text: ". You can check your inbox."
                        )
                      ]),
                ),
                SizedBox(height: 2.2.h),
                Text(
                  "I didn’t received the code? Send again",
                  style: TextStyle(
                      color: AppColors.buttonColor,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                      fontSize: SizerUtil.deviceType == DeviceType.tablet ? 7.sp : 10.sp),
                ),
                SizedBox(height: 4.h),
                CommonButton(onTap: () {}, title: StringRes.verify),
                SizedBox(height: 4.h),
              ],
            ),),


          ],
        ),
      ),
    );
  }
}
