import 'package:expense_tracker/Utils/size_utils.dart';
import 'package:expense_tracker/model/budget_model.dart';
import 'package:expense_tracker/provider/appdata_store_provider.dart';
import 'package:expense_tracker/widgets/back_button.dart';
import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../res/app_colors.dart';
import '../../res/strings.dart';
import '../../widgets/dotted_divider.dart';
import '../../widgets/line_chart_view.dart';

class BudgetDetailScreen extends StatefulWidget {
  const BudgetDetailScreen({Key? key}) : super(key: key);

  @override
  State<BudgetDetailScreen> createState() => _BudgetDetailScreenState();
}

class _BudgetDetailScreenState extends State<BudgetDetailScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BudgetModel model = ModalRoute.of(context)!.settings.arguments as BudgetModel;
    double totalSpend = 0;
    bool exceedLimit = false;
    model.categories!.forEach((element) {
      totalSpend = totalSpend + element.balance!;
    });
    if(totalSpend > model.balance!){
      exceedLimit = true;
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(left: 5.33.w, right: 2.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CommonBackButton()
                ),
                Text(
                  StringRes.budgetDetail,
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: StringRes.appBarTitle.fontWeight,
                      fontSize: StringRes.appBarTitle.fontSize),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      showBottomSheet(model);
                    },
                    child: Image.asset(StringRes.deleteIcon,
                        height: SizerUtil.deviceType == DeviceType.tablet ? 45 : 30, color: AppColors.textColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
            decoration: BoxDecoration(
              color: AppColors.whiteTextColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFE3E5E5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(StringRes.shoppingIcon, height: 32),
                SizedBox(width: 2.w),
                Text(
                  "${model.category}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeUtil.f12),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "Remaining",
            style: TextStyle(
                fontSize: SizeUtil.f14,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor),
          ),
          SizedBox(height: 1.h),
          Text(
            "\$${model.balance! - totalSpend <= 0 ? 0 : model.balance! - totalSpend}",
            style: TextStyle(
                fontSize: SizerUtil.deviceType == DeviceType.tablet ? 25.sp : 30.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor),
          ),
          SizedBox(height: 3.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.w),
            child: LinearPercentIndicator(
              width: 92.w,
              animation: true,
              lineHeight: 15.0,
              animationDuration: 2500,
              barRadius: Radius.circular(14),
              percent: totalSpend / model.balance! >= 1 ? 1 : totalSpend / model.balance!,
              backgroundColor: Color(0xFFF1F1FA),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor:Color(0xFFFCAC12),
            ),
          ),
          SizedBox(height: 3.h),
          exceedLimit ? Container(
            padding: EdgeInsets.symmetric(horizontal: SizerUtil.deviceType == DeviceType.tablet ? 3.w : 1.5.w,vertical: SizerUtil.deviceType == DeviceType.tablet ? 0.5.h : 0.2.h),
            decoration: BoxDecoration(
              color: Color(0xFFFD3C4A),
              borderRadius: BorderRadius.circular(24)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(StringRes.warningIcon,width: 32,color: Colors.white,),
                Text(
                  "You’ve exceed the limit  ",
                  style: TextStyle(
                      fontSize: SizeUtil.f10,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ],
            ),
          ) : const SizedBox(),
          SizedBox(height: 3.h),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.2.w),
            child: CommonButton(onTap: () {
              Navigator.pushNamed(context, '/createBudget',arguments: model);
            }, title: "Edit"),
          ),
          SizedBox(
            height: 4.h,
          ),
        ],
      ),
    );
  }

  /// delete sheet
  Future showBottomSheet(BudgetModel model) {
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
                  "Remove this budget?",
                  style: TextStyle(
                      fontSize: SizeUtil.f14,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Are you sure do you wanna remove this budget?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: SizeUtil.f11,
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
                            Provider.of<AppDataStore>(context,listen: false).removeBudgetItem(model);
                            Navigator.pop(context);
                            Navigator.pop(context);
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
