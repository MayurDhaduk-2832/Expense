import 'package:expense_tracker/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../res/strings.dart';
import '../../widgets/custom_button.dart';
import 'onboard_image_view.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizerUtil.deviceType == DeviceType.tablet ? 76.h : 100.h - 11.h - 112,
                child: OnBoardImageView(),),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.3.w),
              child: CommonButton(
                title: StringRes.signUp,
                onTap: (){
                  Navigator.pushNamed(context, "/signup");
                },
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.3.w),
              child: CommonButton(
                title: StringRes.login,
                onTap: (){
                  Navigator.pushNamed(context, "/login");
                },
                buttonColor: AppColors.secondButtonColor,
                textColor: AppColors.buttonColor,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
          ],
        ),
      ),
    );
  }
}
