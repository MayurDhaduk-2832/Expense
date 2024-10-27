import 'package:expense_tracker/Utils/size_utils.dart';
import 'package:expense_tracker/helper/scroll_behavior.dart';
import 'package:expense_tracker/res/app_colors.dart';
import 'package:expense_tracker/res/strings.dart';
import 'package:expense_tracker/widgets/back_button.dart';
import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:expense_tracker/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CommonBackButton(),
                ),
                Text(
                  StringRes.forgotPassword,
                  style: StringRes.appBarTitle,
                )
              ],
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 12.h),
                      Text(
                        "Don’t worry.\nEnter your email and we’ll send you a link to reset your password.",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: SizeUtil.f18,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      CustomTextField(
                        hintText: "Email",
                        controller: _emailController,
                      ),
                      SizedBox(height: 4.h),
                      CommonButton(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/sendMailSuccess",
                                arguments: _emailController.text);
                          },
                          title: StringRes.continues),
                      SizedBox(height: 4.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
