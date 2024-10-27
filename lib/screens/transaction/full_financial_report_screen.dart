import 'package:expense_tracker/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helper/date_format_helper.dart';
import '../../model/income_expense_model.dart';
import '../../provider/appdata_store_provider.dart';
import '../../res/app_colors.dart';
import '../../res/strings.dart';
import '../../widgets/line_chart_view.dart';
import '../../widgets/pie_chart_view.dart';

class FullFinancialReportScreen extends StatefulWidget {
  const FullFinancialReportScreen({super.key});

  @override
  State<FullFinancialReportScreen> createState() =>
      _FullFinancialReportScreenState();
}

class _FullFinancialReportScreenState extends State<FullFinancialReportScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool _isLineChart = false;
  bool _isIncomeView = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(() {
      if (_tabController!.index == 1) {
        setState(() {
          _isIncomeView = true;
        });
      } else {
        setState(() {
          _isIncomeView = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<AppDataStore>(builder: (context, model, widget) {
          List<IncomeExpenseModel> incomeList = [];
          List<IncomeExpenseModel> expanseList = [];
          double incomeBalance = 0;
          double expenseBalance = 0;
          for (var element in model.incomeDataList) {
            if (DateFormatHelper.isMonth(element.id!)) {
              incomeList.add(element);
              incomeBalance = incomeBalance + element.balance!;
            }
          }
          for (var element in model.expenseDataList) {
            if (DateFormatHelper.isMonth(element.id!)) {
              expanseList.add(element);
              expenseBalance = expenseBalance + element.balance!;
            }
          }
          Map<String, double> chatExpenseData = {};
          Map<String, double> chatIncomeData = {};
          for (var element in incomeList) {
            if (chatIncomeData.containsKey(element.category)) {
              chatIncomeData[element.category!] =
                  chatIncomeData[element.category]! + element.balance!;
            } else {
              chatIncomeData.addAll({element.category!: element.balance!});
            }
          }
          for (var element in expanseList) {
            if (chatIncomeData.containsKey(element.category)) {
              chatExpenseData[element.category!] =
                  chatExpenseData[element.category]! + element.balance!;
            } else {
              chatExpenseData.addAll({element.category!: element.balance!});
            }
          }

          return Column(
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
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: CommonBackButton(),
                    ),
                    Text(
                      StringRes.financialReport,
                      style: StringRes.appBarTitle,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                Device.screenType == ScreenType.tablet ? 20 : 8,
                            vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFF1F1FA)),
                            borderRadius: BorderRadius.circular(40)),
                        child: Row(
                          children: [
                            Image.asset(StringRes.arrowDownIcon,
                                width: Device.screenType == ScreenType.tablet
                                    ? 25
                                    : 15),
                            const SizedBox(width: 10),
                            Text(
                              "Month",
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _chatButton(),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.2.w),
                child: Text(
                  "\$${_isIncomeView ? incomeBalance : expenseBalance}",
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor),
                ),
              ),
              SizedBox(
                height: 30.h,
                width: 100.w,
                child: _isLineChart
                    ? const FiChartPage()
                    : PieChartView(
                        dataMap:
                            _isIncomeView ? chatIncomeData : chatExpenseData),
              ),
              SizedBox(height: 1.5.h),

              /// tab bar
              _tabBar(),
              SizedBox(height: 2.h),

              /// tab view
              _tabVieItem(_isIncomeView ? incomeList : expanseList,
                  balance: _isIncomeView ? incomeBalance : expenseBalance)
            ],
          );
        }),
      ),
    );
  }

  Widget _tabBar() {
    return Center(
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          height: Device.screenType == ScreenType.tablet ? 90 : 56,
          width: 90.w,
          decoration: const BoxDecoration(
            color: Color(0xFFF1F1FA),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            tabs: const <Tab>[
              Tab(
                child: Text(StringRes.expense),
              ),
              Tab(
                child: Text(StringRes.income),
              ),
            ],
            unselectedLabelColor: AppColors.textColor,
            labelColor: AppColors.whiteTextColor,
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
            labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.all(4),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.buttonColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _chatButton() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isLineChart = true;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: _isLineChart ? AppColors.buttonColor : Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              border: Border.all(
                color: _isLineChart
                    ? AppColors.buttonColor
                    : const Color(0xFFF1F1FA),
              ),
            ),
            alignment: Alignment.center,
            child: Image.asset(
              StringRes.lineChartIcon,
              color: !_isLineChart ? AppColors.buttonColor : Colors.white,
              height: Device.screenType == ScreenType.tablet ? 45 : 28,
              width: Device.screenType == ScreenType.tablet ? 45 : 28,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isLineChart = false;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: !_isLineChart ? AppColors.buttonColor : Colors.white,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              border: Border.all(
                color: !_isLineChart
                    ? AppColors.buttonColor
                    : const Color(0xFFF1F1FA),
              ),
            ),
            alignment: Alignment.center,
            child: Image.asset(StringRes.pieChartIcon,
                color: _isLineChart ? AppColors.buttonColor : Colors.white,
                height: Device.screenType == ScreenType.tablet ? 45 : 28,
                width: Device.screenType == ScreenType.tablet ? 45 : 28),
          ),
        ),
      ],
    );
  }

  Widget _tabVieItem(List<IncomeExpenseModel> list, {required double balance}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.2.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Device.screenType == ScreenType.tablet ? 20 : 8,
                    vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFF1F1FA)),
                    borderRadius: BorderRadius.circular(40)),
                child: Row(
                  children: [
                    Image.asset(StringRes.arrowDownIcon,
                        width:
                            Device.screenType == ScreenType.tablet ? 25 : 15),
                    const SizedBox(width: 10),
                    Text(
                      "Transaction",
                      style: TextStyle(
                          fontSize: 10.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Image.asset(StringRes.filterButtonIcon,
                  width: Device.screenType == ScreenType.tablet ? 55 : 38,
                  height: Device.screenType == ScreenType.tablet ? 55 : 38),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        ...list.map((e) => _transactionItem(e, balance: balance)),
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget _transactionItem(IncomeExpenseModel model, {double? balance}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/incomeExpenseDetailScreen",
            arguments: model);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.5.h),
        color: Colors.transparent,
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
                            fontSize: 10.sp, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$${model.balance}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: _isIncomeView
                        ? const Color(0xFF00A86B)
                        : const Color(0xFFFD3C4A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearPercentIndicator(
              width: 91.6.w,
              animation: true,
              lineHeight: 15.0,
              animationDuration: 2500,
              barRadius: const Radius.circular(14),
              percent:
                  model.balance! / balance! >= 1 ? 1 : model.balance! / balance,
              backgroundColor: const Color(0xFFF1F1FA),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: const Color(0xFFFCAC12),
            ),
          ],
        ),
      ),
    );
  }
}
