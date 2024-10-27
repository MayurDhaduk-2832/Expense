import 'package:expense_tracker/Utils/size_utils.dart';
import 'package:expense_tracker/widgets/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../res/app_colors.dart';
import '../../res/strings.dart';

class SetNotificationScreen extends StatefulWidget {
  const SetNotificationScreen({super.key});

  @override
  State<SetNotificationScreen> createState() => _SetNotificationScreenState();
}

class _SetNotificationScreenState extends State<SetNotificationScreen> {
  bool _expense = false;
  bool _budget = false;
  bool _tips = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 7.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.33.w, right: 2.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Align(
                    alignment: Alignment.centerLeft, child: CommonBackButton()),
                Text(
                  StringRes.notification,
                  style: StringRes.appBarTitle,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          const Divider(height: 0),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expense Alert",
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeUtil.f13),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        "Get notification about you're expense",
                        style: TextStyle(
                            color: const Color(0xFF91919F),
                            fontWeight: FontWeight.w500,
                            fontSize: SizeUtil.f10),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                CupertinoSwitch(
                    value: _expense,
                    onChanged: (val) {
                      setState(() {
                        _expense = !_expense;
                      });
                    },
                    activeColor: AppColors.buttonColor,
                    trackColor: const Color(0xFFEEE5FF)),
              ],
            ),
          ),
          SizedBox(height: 2.5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Budget",
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeUtil.f13),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        "Get notification when you're budget exceeding the limit",
                        style: TextStyle(
                            color: const Color(0xFF91919F),
                            fontWeight: FontWeight.w500,
                            fontSize: SizeUtil.f10),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                CupertinoSwitch(
                    value: _budget,
                    onChanged: (val) {
                      setState(() {
                        _budget = !_budget;
                      });
                    },
                    activeColor: AppColors.buttonColor,
                    trackColor: const Color(0xFFEEE5FF)),
              ],
            ),
          ),
          SizedBox(height: 2.5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tips & Articles",
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeUtil.f13),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        "Small & useful pieces of pratical financial advice",
                        style: TextStyle(
                            color: const Color(0xFF91919F),
                            fontWeight: FontWeight.w500,
                            fontSize: SizeUtil.f10),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                CupertinoSwitch(
                    value: _tips,
                    onChanged: (val) {
                      setState(() {
                        _tips = !_tips;
                      });
                    },
                    activeColor: AppColors.buttonColor,
                    trackColor: const Color(0xFFEEE5FF)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
