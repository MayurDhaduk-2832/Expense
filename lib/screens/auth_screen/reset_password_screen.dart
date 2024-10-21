import 'package:expense_tracker/helper/scroll_behavior.dart';
import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../res/app_colors.dart';
import '../../res/strings.dart';
import '../../widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController = TextEditingController();


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
                  child: GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.pop(context);
                      },
                      child: Image.asset(StringRes.backIcon, height: 16)),
                ),
                Text(
                  StringRes.resetPassword,
                  style: StringRes.appBarTitle,
                )
              ],
            ),
            Expanded(child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    CustomTextField(
                      hintText: "New Password",
                      controller: _passwordController,
                    ),
                    SizedBox(height: 3.h),
                    CustomTextField(
                      hintText: "Retype new Password",
                      controller: _passwordController,
                    ),
                    SizedBox(height: 4.h),
                    CommonButton(onTap: () {}, title: StringRes.continues),

                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),),
          ],
        ),
      ),
    );
  }
}
