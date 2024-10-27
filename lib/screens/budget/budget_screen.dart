import 'package:expense_tracker/Utils/size_utils.dart';
import 'package:expense_tracker/model/budget_model.dart';
import 'package:expense_tracker/res/app_colors.dart';
import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/appdata_store_provider.dart';
import '../../res/strings.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  List<String> transactionList = ["Shopping", "Transportation"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttonColor,
      body: Consumer<AppDataStore>(builder: (context, model, widget) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RotationTransition(
                    turns: const AlwaysStoppedAnimation(90 / 360),
                    child: Image.asset(StringRes.arrowDownIcon,
                        width: 22, color: AppColors.whiteTextColor),
                  ),
                  Text(
                    "May",
                    style: TextStyle(
                        color: AppColors.whiteTextColor,
                        fontSize: SizeUtil.f18,
                        fontWeight: FontWeight.w500),
                  ),
                  RotationTransition(
                    turns: const AlwaysStoppedAnimation(270 / 360),
                    child: Image.asset(StringRes.arrowDownIcon,
                        width: 22, color: AppColors.whiteTextColor),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: AppColors.whiteTextColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    model.budgetList.isEmpty
                        ? _placeHolder()
                        : Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: model.budgetList.length,
                                itemBuilder: (context, index) {
                                  return _transactionItem(
                                      model.budgetList[index]);
                                }),
                          ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.2.w, vertical: 1.h),
                      child: CommonButton(
                          onTap: () {
                            Navigator.pushNamed(context, "/createBudget");
                          },
                          title: "Create a budget"),
                    ),
                    SizedBox(height: 14.h),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  /// empty widget
  Widget _placeHolder() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 28.h),
          Text(
            "You don’t have a budget.\nLet’s make one so you in control.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _transactionItem(BudgetModel model) {
    double totalSpend = 0;
    bool exceedLimit = false;
    for (var element in model.categories!) {
      totalSpend = totalSpend + element.balance!;
    }
    if (totalSpend > model.balance!) {
      exceedLimit = true;
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/budgetDetail", arguments: model);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.5.h),
        padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.5.h),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: AppColors.whiteTextColor,
                      border: Border.all(color: const Color(0xFFF1F1FA)),
                      borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFCAC12),
                          ),
                          height: 15,
                          width: 15),
                      const SizedBox(width: 8),
                      Text(
                        model.category!,
                        style: TextStyle(
                            fontSize: SizeUtil.f10,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                exceedLimit
                    ? Image.asset(
                        StringRes.warningIcon,
                        width: 32,
                      )
                    : const SizedBox()
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              "Remaining \$${model.balance! - totalSpend <= 0 ? 0 : model.balance! - totalSpend}",
              style: TextStyle(
                  fontSize: SizeUtil.f16,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 1.h),
            LinearPercentIndicator(
              width: 83.2.w,
              animation: true,
              lineHeight: 15.0,
              animationDuration: 2500,
              barRadius: const Radius.circular(14),
              percent: totalSpend / model.balance! >= 1
                  ? 1
                  : totalSpend / model.balance!,
              backgroundColor: const Color(0xFFF1F1FA),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: const Color(0xFFFCAC12),
            ),
            SizedBox(height: 1.h),
            Text(
              "\$$totalSpend of \$${model.balance}",
              style: TextStyle(
                  fontSize: SizeUtil.f13,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 1.h),
            exceedLimit
                ? Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: Text(
                      "You’ve exceed the limit!",
                      style: TextStyle(
                        fontSize: SizeUtil.f10,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFFD3C4A),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
