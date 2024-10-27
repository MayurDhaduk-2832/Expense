import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:expense_tracker/widgets/custom_drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../res/app_colors.dart';
import '../../res/strings.dart';

class ExportDataScreen extends StatefulWidget {
  const ExportDataScreen({super.key});

  @override
  State<ExportDataScreen> createState() => _ExportDataScreenState();
}

class _ExportDataScreenState extends State<ExportDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 7.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.33.w, right: 2.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(StringRes.backIcon, height: 16)),
                ),
                Text(
                  StringRes.exportData,
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
            height: 4.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What data do your want to export?",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor),
                  ),
                  SizedBox(height: 1.2.h),
                  CustomDropDownField(title: "All", itemList: const []),
                  SizedBox(height: 3.h),
                  Text(
                    "When date range?",
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor),
                  ),
                  SizedBox(height: 1.2.h),
                  CustomDropDownField(
                      title: "Last 30 days", itemList: const []),
                  SizedBox(height: 3.h),
                  Text(
                    "What format do you want to export?",
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor),
                  ),
                  SizedBox(height: 1.2.h),
                  CustomDropDownField(title: "CSV", itemList: const []),
                  const Spacer(),
                  CommonButton(onTap: () {}, title: "Export")
                ],
              ),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
        ],
      ),
    );
  }
}
