import 'package:expense_tracker/res/app_colors.dart';
import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:expense_tracker/widgets/custom_drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/size_utils.dart';
import '../../helper/date_format_helper.dart';
import '../../model/income_expense_model.dart';
import '../../provider/appdata_store_provider.dart';
import '../../res/strings.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<String> filterByList = ["Income", "Expense", "Transfer"];
  List<String> sortByList = ["Highest", "Lowest", "Newest", "Oldest"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.2.w),
        child:Consumer<AppDataStore>(
            builder: (context,model,widget) {
            List<IncomeExpenseModel> list = [];
            List<IncomeExpenseModel> todayList = [];
            List<IncomeExpenseModel> yesterdayList = [];
            list.addAll(model.incomeDataList);
            list.addAll(model.expenseDataList);
            list.sort((b, a) => a.id!.compareTo(b.id!));
            list.forEach((element) {
              if(DateFormatHelper.isToday(element.id!)){
                todayList.add(element);
              } else{
               yesterdayList.add(element);
              }
            });


            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 7.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: SizerUtil.deviceType == DeviceType.tablet ? 60 :40,
                      padding: EdgeInsets.symmetric(horizontal: SizerUtil.deviceType == DeviceType.tablet ? 25 :10,),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFF1F1FA)),
                          borderRadius: BorderRadius.circular(40)),
                      child: Row(
                        children: [
                          Image.asset(StringRes.arrowDownIcon, width: SizerUtil.deviceType == DeviceType.tablet ? 25 :15),
                          SizedBox(width: 10),
                          Text(
                            "Month",
                            style: TextStyle(
                                fontSize: 10.sp, color: AppColors.textColor),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        filterBottomSheet();
                      },
                      child: Image.asset(
                        StringRes.filterIcon,
                        height: SizerUtil.deviceType == DeviceType.tablet ? 50 :40,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: (){
                    if(model.expenseDataList.isEmpty || model.incomeDataList.isEmpty){
                      Fluttertoast.showToast(msg: "Financial report not available");
                    }else{
                    Navigator.pushNamed(context, "/financialReport");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEEE5FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.8.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "See your financial report",
                            style: TextStyle(
                                fontSize: SizeUtil.f12, color: AppColors.buttonColor),
                          ),
                        ),
                        const SizedBox(width: 10),
                        RotationTransition(
                          turns: const AlwaysStoppedAnimation(270 / 360),
                          child: Image.asset(StringRes.arrowDownIcon, width: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        todayList.isEmpty ? const SizedBox() : Text(
                          "Today",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: todayList.isEmpty ? 0 : 1.h),
                        ...todayList.map((e) => _transactionItem(e)).toList(),
                        SizedBox(height: 2.h),
                        yesterdayList.isEmpty ? const SizedBox() : Text(
                          "Yesterday",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: yesterdayList.isEmpty ? 0 : 1.h),

                      ],
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _transactionItem(IncomeExpenseModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.7.h),
      padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 4.2.w),
      decoration: BoxDecoration(
        color: Color(0xFFFCFCFC),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
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
    );
  }

  Future filterBottomSheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 4.2.w),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Center(
                  child: Container(
                    width: 35,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Color(0xFFD3BDFF),
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filter Transaction",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: SizeUtil.f13,
                          color: AppColors.textColor),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Chip(
                        backgroundColor: Color(0xFFEEE5FF),
                        label: Text(
                          " Reset ",
                          style: TextStyle(
                            fontSize: SizeUtil.f10,
                              color: AppColors.buttonColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Filter By",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: SizeUtil.f13,
                      color: AppColors.textColor),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 2.w,
                  runSpacing: 0.1.h,
                  children: [
                    ...filterByList.map((e) {
                      bool isSelect = false;
                      return FilterChip(
                        label: Text(e),
                        labelStyle: TextStyle(
                            fontSize: SizeUtil.f10,
                            color: isSelect
                            ? AppColors.buttonColor : AppColors.textColor),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.2.h, horizontal: 3.w),
                        selectedColor: const Color(0xFFEEE5FF),
                        backgroundColor: isSelect
                            ?const Color(0xFFEEE5FF) : Colors.white,
                        shape: StadiumBorder(
                          side: BorderSide(
                            color: isSelect
                                ? const Color(0xFFEEE5FF)
                                : const Color(
                                    0xFFE3E5E5,
                                  ),
                          ),
                        ),
                        onSelected: (bool value) {
                          print("selected");
                        },
                      );
                    }).toList()
                  ],
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Text(
                  "Sory By",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: SizeUtil.f13,
                      color: AppColors.textColor),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 2.w,
                  runSpacing: 0.1.h,
                  children: [
                    ...sortByList.map((e) {
                      bool isSelect = false;
                      return FilterChip(
                        label: Text(e),
                        labelStyle: TextStyle(
                            fontSize: SizeUtil.f10,
                            color: isSelect
                            ? AppColors.buttonColor : AppColors.textColor),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.2.h, horizontal: 3.w),
                        selectedColor: const Color(0xFFEEE5FF),
                        backgroundColor: isSelect
                            ?const Color(0xFFEEE5FF) : Colors.white,
                        shape: StadiumBorder(
                          side: BorderSide(
                            color: isSelect
                                ? const Color(0xFFEEE5FF)
                                : const Color(
                                    0xFFE3E5E5,
                                  ),
                          ),
                        ),
                        onSelected: (bool value) {
                          print("selected");
                        },
                      );
                    }).toList()
                  ],
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Text(
                  "Category",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: SizeUtil.f13,
                      color: AppColors.textColor),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Choose Category",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: SizeUtil.f11,
                            color: AppColors.textColor),
                      ),
                    ),Text(
                      "0 Selected",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeUtil.f11,
                          color: const Color(0xFF91919F)),
                    ),
                    const SizedBox(width: 5),
                    RotationTransition(
                      turns: const AlwaysStoppedAnimation(270 / 360),
                      child: Image.asset(StringRes.arrowDownIcon, width: 14,),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                CommonButton(onTap: (){
                  Navigator.pop(context);
                }, title: "Apply"),
                SizedBox(
                  height: 4.h,
                ),
              ],
            ),
          );
        });
  }
}
