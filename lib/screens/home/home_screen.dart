import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/size_utils.dart';
import '../../helper/date_format_helper.dart';
import '../../model/income_expense_model.dart';
import '../../provider/appdata_store_provider.dart';
import '../../res/app_colors.dart';
import '../../res/strings.dart';
import '../../widgets/line_chart_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Consumer<AppDataStore>(
          builder: (context,model,widget) {
            double totalBalance = 0;
            double incomeBalance = 0;
            double expenseBalance = 0;
            for (var element in model.accountList) {
              totalBalance = totalBalance + element.accBalance!;
            } for (var element in model.incomeDataList) {
              incomeBalance = incomeBalance + element.balance!;
            } for (var element in model.expenseDataList) {
              expenseBalance = expenseBalance + element.balance!;
            }
            return ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: NestedScrollView(
                  physics: ScrollPhysics(),
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context,inner) => [_appBar(totalBalance,incomeBalance,expenseBalance)],
                  body: ListView(
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      // Container(
                      //   decoration: BoxDecoration(
                      //       borderRadius: const BorderRadius.only(
                      //         bottomLeft: Radius.circular(32),
                      //         bottomRight: Radius.circular(32),
                      //       ),
                      //       gradient: LinearGradient(
                      //           colors: [
                      //             const Color(0xFFFFF6E5),
                      //             const Color.fromRGBO(248, 237, 216, 0).withOpacity(0.2)
                      //           ],
                      //           stops: const [
                      //             0.0,
                      //             1.0
                      //           ],
                      //           begin: FractionalOffset.topCenter,
                      //           end: FractionalOffset.bottomCenter,
                      //           tileMode: TileMode.clamp)),
                      //   child: Column(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       SizedBox(height: 6.5.h),
                      //       Padding(
                      //         padding: EdgeInsets.symmetric(horizontal: 4.w),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Stack(
                      //               alignment: Alignment.center,
                      //               children: [
                      //                 Container(
                      //                   height: SizerUtil.deviceType == DeviceType.tablet
                      //                       ? 65
                      //                       : 34,
                      //                   width: SizerUtil.deviceType == DeviceType.tablet
                      //                       ? 65
                      //                       : 34,
                      //                   decoration: BoxDecoration(
                      //                       shape: BoxShape.circle,
                      //                       border:
                      //                           Border.all(color: AppColors.buttonColor)),
                      //                 ),
                      //                 Container(
                      //                   height: SizerUtil.deviceType == DeviceType.tablet
                      //                       ? 60
                      //                       : 29,
                      //                   width: SizerUtil.deviceType == DeviceType.tablet
                      //                       ? 60
                      //                       : 29,
                      //                   decoration: BoxDecoration(
                      //                     image: const DecorationImage(
                      //                         fit: BoxFit.cover,
                      //                         image:
                      //                             AssetImage(StringRes.tempModelImage)),
                      //                     shape: BoxShape.circle,
                      //                     color: Colors.grey.withOpacity(0.20),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             Container(
                      //               padding: EdgeInsets.symmetric(
                      //                   horizontal:
                      //                       SizerUtil.deviceType == DeviceType.tablet
                      //                           ? 25
                      //                           : 7,
                      //                   vertical: 8),
                      //               decoration: BoxDecoration(
                      //                   border:
                      //                       Border.all(color: const Color(0xFFF1F1FA)),
                      //                   borderRadius: BorderRadius.circular(40)),
                      //               child: Row(
                      //                 children: [
                      //                   Image.asset(StringRes.arrowDownIcon,
                      //                       width:
                      //                           SizerUtil.deviceType == DeviceType.tablet
                      //                               ? 25
                      //                               : 15),
                      //                   SizedBox(width: 10),
                      //                   Text(
                      //                     "October",
                      //                     style: TextStyle(
                      //                         fontSize: 11.sp,
                      //                         fontWeight: FontWeight.w500),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             GestureDetector(
                      //                 onTap: () {
                      //                   Navigator.pushNamed(context, "/notification");
                      //                 },
                      //                 child: Image.asset(
                      //                   StringRes.notificationIcon,
                      //                   height: SizerUtil.deviceType == DeviceType.tablet
                      //                       ? 50
                      //                       : 34,
                      //                   width: SizerUtil.deviceType == DeviceType.tablet
                      //                       ? 50
                      //                       : 34,
                      //                 ))
                      //           ],
                      //         ),
                      //       ),
                      //       SizedBox(height: 2.5.h),
                      //       Text(
                      //         "Account Balance",
                      //         style: TextStyle(
                      //           fontSize: SizeUtil.f11,
                      //           color: const Color(0xFF91919F),
                      //         ),
                      //       ),
                      //       SizedBox(height: 1.5.h),
                      //       Text(
                      //         "\$$totalBalance",
                      //         style: TextStyle(
                      //             fontSize: SizerUtil.deviceType == DeviceType.tablet ? 25.sp : 30.sp,
                      //             fontWeight: FontWeight.w600,
                      //             color: AppColors.textColor),
                      //       ),
                      //       SizedBox(height: 3.h),
                      //       Row(children: [
                      //         SizedBox(width: 4.2.w),
                      //
                      //         /// income widget
                      //         _incomeExpenseWidget(type: StringRes.income, value: "$incomeBalance"),
                      //         SizedBox(width: 4.2.w),
                      //         _incomeExpenseWidget(
                      //             type: StringRes.expense, value: "$expenseBalance"),
                      //         SizedBox(width: 4.2.w),
                      //       ]),
                      //       SizedBox(height: 3.h),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.2.w),
                        child: Text(
                          "Spend Frequency",
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                        width: 100.w,
                        child: const FiChartPage(),
                      ),
                      SizedBox(height: 1.5.h),

                      /// tab bar
                      _tabBar(),
                      SizedBox(height: 2.h),

                      /// tab view
                      _tabView(model)
                    ],
                  )
              ),
            );
        }
      ),
    );
  }

  Widget _appBar(double totalBal,incomeBal,expenseBal) {
    return SliverAppBar(
      elevation: 0,
      expandedHeight: 35.h,
      pinned: true,
      backgroundColor:  const Color(0xFFFFF6E5),
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32))),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: SizerUtil.deviceType == DeviceType.tablet
                    ? 65
                    : 34,
                width: SizerUtil.deviceType == DeviceType.tablet
                    ? 65
                    : 34,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                    Border.all(color: AppColors.buttonColor)),
              ),
              Container(
                height: SizerUtil.deviceType == DeviceType.tablet
                    ? 60
                    : 29,
                width: SizerUtil.deviceType == DeviceType.tablet
                    ? 60
                    : 29,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image:
                      AssetImage(StringRes.tempModelImage)),
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.20),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal:
                SizerUtil.deviceType == DeviceType.tablet
                    ? 25
                    : 7,
                vertical: 8),
            decoration: BoxDecoration(
                border:
                Border.all(color: const Color(0xFFF1F1FA)),
                borderRadius: BorderRadius.circular(40)),
            child: Row(
              children: [
                Image.asset(StringRes.arrowDownIcon,
                    width:
                    SizerUtil.deviceType == DeviceType.tablet
                        ? 25
                        : 15),
                SizedBox(width: 10),
                Text(
                  "October",
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/notification");
              },
              child: Image.asset(
                StringRes.notificationIcon,
                height: SizerUtil.deviceType == DeviceType.tablet
                    ? 50
                    : 34,
                width: SizerUtil.deviceType == DeviceType.tablet
                    ? 50
                    : 34,
              ))
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              gradient: LinearGradient(
                  colors: [
                    // const Color(0xFFFFF6E5),
                    const Color(0xFFFFF6E5),
                    const Color.fromRGBO(248, 237, 216, 0).withOpacity(0.2)
                  ],
                  stops: const [
                    0.0,
                    1.0
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  tileMode: TileMode.clamp)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Account Balance",
                style: TextStyle(
                  fontSize: SizeUtil.f11,
                  color: const Color(0xFF91919F),
                ),
              ),
              SizedBox(height: 1.5.h),
              Text(
                "\$$totalBal",
                style: TextStyle(
                    fontSize: SizerUtil.deviceType == DeviceType.tablet ? 25.sp : 30.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor),
              ),
              SizedBox(height: 3.h),
              Row(children: [
                SizedBox(width: 4.2.w),

                /// income widget
                _incomeExpenseWidget(type: StringRes.income, value: "$incomeBal"),
                SizedBox(width: 4.2.w),
                _incomeExpenseWidget(
                    type: StringRes.expense, value: "$expenseBal"),
                SizedBox(width: 4.2.w),
              ]),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _incomeExpenseWidget({required String type, required String value}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Navigator.pushNamed(context, "/addExpenses",arguments: type);
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 7, vertical:SizerUtil.deviceType == DeviceType.tablet ? 20 : 14),
          decoration: BoxDecoration(
            color: type == StringRes.income
                ? const Color(0xFF00A86B)
                : const Color(0xFFFD3C4A),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 5),
              Image.asset(
                  type == StringRes.income
                      ? StringRes.incomeIcon
                      : StringRes.expensesIcon,
                  width:SizerUtil.deviceType == DeviceType.tablet ? 90 : 52),
              SizedBox(width:SizerUtil.deviceType == DeviceType.tablet ? 25: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type,
                      style: TextStyle(
                          fontSize: SizeUtil.f11, color: AppColors.whiteTextColor),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "\$$value",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: SizeUtil.f16,
                          color: AppColors.whiteTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.2.w),
      height: SizerUtil.deviceType == DeviceType.tablet ? 70 : 35,
      color: Colors.transparent,
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            25.0,
          ),
          color: const Color(0xFFFCEED4),
        ),
        labelColor: const Color(0xFFFCAC12),
        unselectedLabelColor: const Color(0xFF91919F),
        labelStyle: TextStyle(
          fontSize: SizeUtil.f12,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: SizeUtil.f12,
        ),
        tabs: const [
          Tab(
            child: Text(
              "Today",
            ),
          ),
          Tab(
            child: Text(
              "Week",
            ),
          ),
          Tab(
            child: Text(
              "Month",
            ),
          ),
          Tab(
            child: Text(
              "Year",
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabView(AppDataStore store) {
    List<IncomeExpenseModel> list = [];
    list.addAll(store.incomeDataList);
    list.addAll(store.expenseDataList);
    list.sort((b, a) => a.id!.compareTo(b.id!));
    return _tabVieItem(list);
  }

  Widget _tabVieItem(List<IncomeExpenseModel> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.2.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Transaction",
                style: TextStyle(
                    fontSize: SizeUtil.f12,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600),
              ),
              Chip(
                backgroundColor: const Color(0xFFEEE5FF),
                label: Text(
                  "See All",
                  style: TextStyle(
                      fontSize: 9.sp,
                      color: AppColors.buttonColor,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
        ...list.map((e) => _transactionItem(e)).toList(),
        SizedBox(height: 12.h),
        // Expanded(
        //   child: ListView.builder(
        //     padding: EdgeInsets.zero,
        //     physics: NeverScrollableScrollPhysics(),
        //     shrinkWrap: true,
        //       itemCount: list.length,
        //       itemBuilder: (context,index){
        //     return _transactionItem();
        //   }),
        // )

      ],
    );
  }

  Widget _transactionItem(IncomeExpenseModel model) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "/addExpenses",arguments: model);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 0.7.h),
        padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 4.2.w),
        decoration: BoxDecoration(
          color: Color(0xFFFCFCFC),
          borderRadius: BorderRadius.circular(24),
        ),
        child:  Row(
          children: [
            Image.asset(
              StringRes.subscriptionIcon,
              height: 60,
              width: 60,
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          model.category!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: SizeUtil.f12,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "\$${model.balance}",
                        style: TextStyle(
                            fontSize: SizeUtil.f12,
                            color: model.type == StringRes.income ? Color(0xFF00A86B) : Color(0xFFFD3C4A),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          model.description!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: SizeUtil.f11,
                              color: Color(0xFF91919F),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        DateFormatHelper.dateFormat(model.id!),
                        style: TextStyle(
                            fontSize: SizeUtil.f10,
                            color: Color(0xFF91919F),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
