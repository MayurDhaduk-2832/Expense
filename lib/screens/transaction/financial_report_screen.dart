import 'package:expense_tracker/helper/date_format_helper.dart';
import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../model/income_expense_model.dart';
import '../../provider/appdata_store_provider.dart';
import '../../res/app_colors.dart';
import '../../res/strings.dart';
import '../../widgets/dot_indicator.dart';

class FinancialReportScreen extends StatefulWidget {
  const FinancialReportScreen({super.key});

  @override
  State<FinancialReportScreen> createState() => _FinancialReportScreenState();
}

class _FinancialReportScreenState extends State<FinancialReportScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pageList = [
      _expenseWidget(),
      _incomeWidget(),
      _financialWidget(),
      _seeFinancialWidget()
    ];
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
              onPageChanged: (val) {
                setState(() {
                  _currentIndex = val;
                });
              },
              itemCount: pageList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return pageList[index];
              }),
          Positioned(
            top: 10.h,
            child: DotsIndicator(
              dotsCount: 4,
              position: _currentIndex.toDouble(),
              decorator: DotsDecorator(
                color: Colors.white.withOpacity(0.20),
                activeColor: Colors.white,
                spacing: EdgeInsets.symmetric(horizontal: 0.6.w),
                size: Size(22.w, 6.0),
                activeSize: Size(22.w, 6.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _expenseWidget() {
    return Consumer<AppDataStore>(builder: (context, model, widget) {
      List<IncomeExpenseModel> list = [];
      double balance = 0;
      for (var element in model.expenseDataList) {
        if (DateFormatHelper.isMonth(element.id!)) {
          list.add(element);
          balance = balance + element.balance!;
        }
      }
      list.sort((b, a) => a.balance!.compareTo(b.balance!));

      return Container(
        height: 100.h,
        width: 100.w,
        color: const Color(0xFFFD3C4A),
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Text(
              "This Month",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.72), fontSize: 18.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "You Spend 💸",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "\$$balance",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 30.sp),
            ),
            const Spacer(),
            Container(
              width: 91.6.w,
              margin: EdgeInsets.symmetric(horizontal: 4.2.w),
              padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 2.5.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "and your biggest \nspending is from",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
                    decoration: BoxDecoration(
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
                          "${list.first.category}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "\$${list.first.balance}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
          ],
        ),
      );
    });
  }

  Widget _incomeWidget() {
    return Consumer<AppDataStore>(builder: (context, model, widget) {
      List<IncomeExpenseModel> list = [];
      double balance = 0;
      for (var element in model.incomeDataList) {
        if (DateFormatHelper.isMonth(element.id!)) {
          list.add(element);
          balance = balance + element.balance!;
        }
      }
      list.sort((b, a) => a.balance!.compareTo(b.balance!));
      return Container(
        height: 100.h,
        width: 100.w,
        color: const Color(0xFF00A86B),
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Text(
              "This Month",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.72), fontSize: 18.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "You Earned 💰",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "\$$balance",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 30.sp),
            ),
            const Spacer(),
            Container(
              width: 91.6.w,
              margin: EdgeInsets.symmetric(horizontal: 4.2.w),
              padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 2.5.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "your biggest \nIncome is from",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 4.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFE3E5E5),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(StringRes.salaryIcon, height: 32),
                        SizedBox(width: 2.w),
                        Text(
                          "${list.first.category}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "\$${list.first.balance}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
          ],
        ),
      );
    });
  }

  Widget _financialWidget() {
    return Container(
      height: 100.h,
      width: 100.w,
      color: const Color(0xFF7F3DFF),
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Text(
            "This Month",
            style: TextStyle(
                color: Colors.white.withOpacity(0.72), fontSize: 18.sp),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              "2 of 12 Budget is exceeds the limit",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
                decoration: BoxDecoration(
                  color: AppColors.whiteTextColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(StringRes.shoppingIcon, height: 32),
                    SizedBox(width: 2.w),
                    Text(
                      "Shopping",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5.w),
              Container(
                padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
                decoration: BoxDecoration(
                  color: AppColors.whiteTextColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(StringRes.foodIcon, height: 32),
                    SizedBox(width: 2.w),
                    Text(
                      "Food",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _seeFinancialWidget() {
    return Container(
      height: 100.h,
      width: 100.w,
      color: const Color(0xFF7F3DFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 28.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              "“Financial freedom is freedom from fear.”",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp),
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              "-Robert Kiyosaki",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.2.w),
            child: CommonButton(
              onTap: () {
                Navigator.pushReplacementNamed(context, "/fullFinancialReport");
              },
              title: "See the full detail",
              buttonColor: Colors.white,
              textColor: AppColors.buttonColor,
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
