import 'package:expense_tracker/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/size_utils.dart';
import '../../res/app_colors.dart';
import '../../res/strings.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
                  alignment: Alignment.centerLeft,
                  child: CommonBackButton(),
                ),
                Text(
                  StringRes.notification,
                  style: StringRes.appBarTitle,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: PopupMenuButton(
                      iconSize:
                          Device.screenType == ScreenType.tablet ? 45 : 25,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          child: Text("Mark all read"),
                        ),
                        const PopupMenuItem(
                          child: Text("Remove all"),
                        ),
                      ],
                    )

                    // GestureDetector(
                    //   onTap: () {
                    //     FocusManager.instance.primaryFocus?.unfocus();
                    //     Navigator.pop(context);
                    //   },
                    //   child: const Icon(Icons.more_horiz,
                    //       color: AppColors.textColor),
                    // ),
                    ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 40.h),
          //     child:Text(
          //   "There is no notification for now",
          //   style: TextStyle(
          //       fontWeight: FontWeight.w500,
          //       color: const Color(0xFF91919F),
          //       fontSize: 10.sp),
          // ) ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder: (context, index) {
                return _item();
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _item() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.33.w, vertical: 0.5.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Shopping budget has exceeds the..",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                      fontSize: SizeUtil.f12),
                ),
                const SizedBox(height: 5),
                Text(
                  "Your Shopping budget has exceeds the lim....",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF91919F),
                      fontSize: SizeUtil.f10),
                )
              ],
            ),
          ),
          Text(
            "19.30",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF91919F),
                fontSize: SizeUtil.f10),
          )
        ],
      ),
    );
  }
}
