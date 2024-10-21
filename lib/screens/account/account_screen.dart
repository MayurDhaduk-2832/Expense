import 'package:expense_tracker/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helper/shared_pref_helper.dart';
import '../../res/strings.dart';
import '../../widgets/custom_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.33.w),
        child: Column(
          children: [
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  height: SizerUtil.deviceType == DeviceType.tablet ? 150 : 84,
                  width: SizerUtil.deviceType == DeviceType.tablet ? 150 : 84,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.buttonColor, width: 2),
                      shape: BoxShape.circle,
                      color: Colors.transparent),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(StringRes.tempModelImage)
                        ),
                        color: AppColors.greyColor.withOpacity(0.20)),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
                        style: TextStyle(
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp),
                      ),
                      SizedBox(
                        height: 0.6.h,
                      ),
                      Text(
                        "Iriana Saliha",
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  StringRes.editIcon,
                  width: SizerUtil.deviceType == DeviceType.tablet ? 50 : 32,
                )
              ],
            ),
            SizedBox(height: 5.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  _item(
                      title: StringRes.account,
                      image: StringRes.accountIcon,
                      onTap: () {
                        Navigator.pushNamed(context, "/accountDetails");
                      }),
                  const Divider(
                    height: 0,
                  ),
                  _item(
                      title: StringRes.setting,
                      image: StringRes.settingIcon,
                      onTap: () {
                        Navigator.pushNamed(context, "/setting");
                      }),
                  const Divider(
                    height: 0,
                  ),
                  _item(
                      title: StringRes.exportData,
                      image: StringRes.exportIcon,
                      onTap: () {
                        Navigator.pushNamed(context, "/exportData");
                      }),
                  const Divider(
                    height: 0,
                  ),
                  _item(
                      title: StringRes.logout,
                      image: StringRes.logoutIcon,
                      onTap: () {
                        showBottomSheet();
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
      {required String title, required String image, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.8.h),
        color: Colors.transparent,
        child: Row(children: [
          Image.asset(image, height: 52),
          SizedBox(width: 2.w),
          Text(
            title,
            style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp),
          ),
        ]),
      ),
    );
  }

  /// logout sheet
  Future showBottomSheet() {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 4.2.w),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 35,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Color(0xFFD3BDFF),
                      borderRadius: BorderRadius.circular(30)),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Text(
                  "Logout?",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Are you sure do you wanna logout?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CommonButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: "No",
                        textColor: AppColors.buttonColor,
                        buttonColor: Color(0xFFEEE5FF),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      flex: 1,
                      child: CommonButton(
                          onTap: () {
                            SharedPreferencesConst.setAppPin('');
                            Navigator.pushNamedAndRemoveUntil(context,"/onBoard",(route) => false,);
                          },
                          title: "Yes"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
              ],
            ),
          );
        });
  }
}
