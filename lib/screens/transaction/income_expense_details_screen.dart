import 'dart:io';

import 'package:expense_tracker/Utils/size_utils.dart';
import 'package:expense_tracker/model/income_expense_model.dart';
import 'package:expense_tracker/provider/appdata_store_provider.dart';
import 'package:expense_tracker/widgets/back_button.dart';
import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helper/image_and_file_picker.dart';
import '../../res/app_colors.dart';
import '../../res/strings.dart';
import '../../widgets/dotted_divider.dart';

class IncomeExpenseDetailScreen extends StatefulWidget {
  const IncomeExpenseDetailScreen({Key? key}) : super(key: key);

  @override
  State<IncomeExpenseDetailScreen> createState() =>
      _IncomeExpenseDetailScreenState();
}

class _IncomeExpenseDetailScreenState extends State<IncomeExpenseDetailScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    IncomeExpenseModel model = ModalRoute.of(context)!.settings.arguments as IncomeExpenseModel;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 4.h),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: const Radius.circular(32),
                      bottomRight: const Radius.circular(32),
                    ),
                    color: model.type == StringRes.income ? const Color(0xFF00A86B) :const Color(0xFFFD3C4A)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.only(left: 5.33.w, right: 2.w),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CommonBackButton(color: AppColors.whiteTextColor,)
                          ),
                          Text(
                            StringRes.detailTransaction,
                            style: TextStyle(
                                color: AppColors.whiteTextColor,
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
                                  height: SizerUtil.deviceType == DeviceType.tablet ? 45: 30, color: AppColors.whiteTextColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "\$${model.balance}",
                      style: TextStyle(
                          fontSize: SizerUtil.deviceType == DeviceType.tablet ? 25.sp : 30.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteTextColor),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      "Buy some grocery",
                      style: TextStyle(
                          fontSize: SizeUtil.f11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.whiteTextColor),
                    ),
                    SizedBox(height: 8),
                    Text(
                      DateFormat('EEEE dd MMM yyyy hh:mm').format(DateTime.fromMicrosecondsSinceEpoch(model.id!)),
                      style: TextStyle(
                          fontSize: SizeUtil.f9,
                          color: AppColors.whiteTextColor,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 6.h),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.2.w),
                  width: 91.6.w,
                  padding: EdgeInsets.symmetric(vertical: 1.2.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFFF1F1FA),
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      _item(title: "Type", subTitle: "${model.type}"),
                      _item(title: "Category", subTitle: "${model.category}"),
                      _item(title: "Wallet", subTitle: "${model.account!.accName}"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.2.w),
            child: DottedDivider(
              height: 2,
              color: Color(0xFFE3E5E5),
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.2.w),
            child: Text(
              "Description",
              style: TextStyle(
                  fontSize: SizeUtil.f13,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 1.5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.2.w),
            child: Text(
              "${model.description}",
              style: TextStyle(
                  fontSize: SizeUtil.f11,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.2.w),
            child: Text(
              "Attachment",
              style: TextStyle(
                  fontSize: SizeUtil.f13,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 1.5.h),
          model.image == null || model.image == '' ? const SizedBox() : Container(
            margin: EdgeInsets.symmetric(horizontal: 4.2.w),
            height: 15.h,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File("${Provider.of<AppDataStore>(context,listen: true).appDirectoryPath}/image${model.id}.png"),),
                ),
                color: AppColors.greyColor.withOpacity(0.20),
                borderRadius: BorderRadius.circular(8)),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.2.w),
            child: CommonButton(onTap: () {}, title: "Edit"),
          ),
          SizedBox(
            height: 4.h,
          ),
        ],
      ),
    );
  }

  Widget _item({required String title, required String subTitle}) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: SizeUtil.f10,
                fontWeight: FontWeight.w400,
                color: Color(0xFF91919F)),
          ),
          SizedBox(height: 0.9.h),
          Text(
            subTitle,
            style: TextStyle(
                fontSize: SizeUtil.f11,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor),
          ),
        ],
      ),
    );
  }

  /// delete sheet
  Future showBottomSheet(IncomeExpenseModel model) {
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
                  "Remove this transaction?",
                  style: TextStyle(
                      fontSize: SizeUtil.f14,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Are you sure do you wanna remove this transaction?",
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
                      child: CommonButton(onTap: () {
                        Navigator.pop(context);
                      }, title: "No",textColor: AppColors.buttonColor,buttonColor: Color(0xFFEEE5FF),),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      flex: 1,
                      child: CommonButton(onTap: () {
                        Navigator.pop(context);
                        showSuccessDialog();
                        if(model.type == StringRes.income){
                        Provider.of<AppDataStore>(context,listen: false).removeIncomeItem(model);
                        Provider.of<AppDataStore>(context,listen: false).updateAccountBalance(model.account!, action: BalanceAction.remove, amount: model.balance!);
                        }else{
                        Provider.of<AppDataStore>(context,listen: false).removeExpenseItem(model);
                        Provider.of<AppDataStore>(context,listen: false).updateAccountBalance(model.account!, action: BalanceAction.add, amount: model.balance!);
                        }
                        Provider.of<AppDataStore>(context,listen: false).removeBudgetData(model);
                      }, title: "Yes"),
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

  /// show success dialog
  Future showSuccessDialog() {
    Future.delayed(Duration(milliseconds: 500),() {
      Navigator.pop(context);
      Navigator.pop(context);
    },);
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 3.h),
                  Image.asset(StringRes.allSetIcon,
                      color: AppColors.buttonColor, width: 48, height: 48),
                  SizedBox(height: 2.h),
                  Text(
                    "Transaction has been successfully removed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: SizeUtil.f12,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          );
        });
  }

}

