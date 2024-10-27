import 'package:expense_tracker/Utils/size_utils.dart';
import 'package:expense_tracker/helper/scroll_behavior.dart';
import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../res/app_colors.dart';
import '../../res/strings.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

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
                    alignment: Alignment.centerLeft, child: CommonBackButton()),
                Text(
                  StringRes.login,
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
                      SizedBox(height: 5.h),
                      CommonButton(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/setUpPin",
                              arguments: true);
                        },
                        title: StringRes.login,
                      ),
                      SizedBox(height: 4.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/forgotPassword");
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: AppColors.buttonColor,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeUtil.f12,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      RichText(
                        text: TextSpan(
                          text: "Don’t have an account yet? ",
                          style: TextStyle(
                            color: const Color(0xFF91919F),
                            fontWeight: FontWeight.w500,
                            fontSize: SizeUtil.f12,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, "/signup");
                                },
                              style: TextStyle(
                                color: AppColors.buttonColor,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeUtil.f12,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
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
