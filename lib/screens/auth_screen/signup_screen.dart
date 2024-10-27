import 'package:expense_tracker/widgets/back_button.dart';
import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/size_utils.dart';
import '../../helper/scroll_behavior.dart';
import '../../res/app_colors.dart';
import '../../res/strings.dart';
import '../../widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _checkTerms = false;

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
                  StringRes.signUp,
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
                      CustomTextField(
                        hintText: "Name",
                        controller: _nameController,
                      ),
                      SizedBox(height: 3.h),
                      CustomTextField(
                        hintText: "Email",
                        controller: _emailController,
                      ),
                      SizedBox(height: 3.h),
                      CustomTextField(
                        hintText: "Password",
                        controller: _passwordController,
                        obscureText: _showPassword,
                        onTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _checkTerms = !_checkTerms;
                              });
                            },
                            child: Container(
                              height: Device.screenType == ScreenType.tablet
                                  ? 40
                                  : 24,
                              width: Device.screenType == ScreenType.tablet
                                  ? 40
                                  : 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: AppColors.buttonColor, width: 2),
                                  color: _checkTerms
                                      ? AppColors.buttonColor
                                      : Colors.transparent),
                              child: Icon(Icons.check,
                                  size: Device.screenType == ScreenType.tablet
                                      ? 28
                                      : 18,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: "By signing up, you agree to the ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeUtil.f12),
                                  children: [
                                    TextSpan(
                                      text:
                                          "Terms of Service and Privacy Policy",
                                      style: TextStyle(
                                          color: AppColors.buttonColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: SizeUtil.f12),
                                    )
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      CommonButton(
                          onTap: () {
                            Navigator.pushNamed(context, "/otpVerification");
                          },
                          title: StringRes.signUp),
                      SizedBox(height: 1.5.h),
                      Text(
                        "Or with",
                        style: TextStyle(
                            color: const Color(0xFF91919F),
                            fontWeight: FontWeight.w600,
                            fontSize: SizeUtil.f12),
                      ),
                      SizedBox(height: 1.5.h),

                      /// login with google
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height:
                              Device.screenType == ScreenType.tablet ? 90 : 56,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: const Color.fromRGBO(241, 241, 250, 1)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(StringRes.googleIcon, height: 30),
                              SizedBox(width: 2.w),
                              Text(
                                StringRes.signUpwithGoogle,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeUtil.f14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 2.2.h),
                      RichText(
                        text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                                color: const Color(0xFF91919F),
                                fontWeight: FontWeight.w500,
                                fontSize: SizeUtil.f12),
                            children: [
                              TextSpan(
                                text: "Login",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, "/login");
                                  },
                                style: TextStyle(
                                    color: AppColors.buttonColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: SizeUtil.f12),
                              )
                            ]),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
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
