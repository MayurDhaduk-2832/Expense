import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../model/account_model.dart';
import '../../provider/appdata_store_provider.dart';
import '../../res/app_colors.dart';
import '../../res/strings.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_drop_down_field.dart';
import '../../widgets/custom_text_field.dart';

class SetupAccountScreen extends StatefulWidget {
  const SetupAccountScreen({Key? key}) : super(key: key);

  @override
  State<SetupAccountScreen> createState() => _SetupAccountScreenState();
}

class _SetupAccountScreenState extends State<SetupAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectAccountType = '';
  String _selectBank = '';
  final _formKey = GlobalKey<FormState>();
  bool _setUpScreens = true;
  bool _allSets = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
            child: _allSets
                ? _allSet()
                : _setUpScreens
                    ? _setUpScreen()
                    : _addAccountScreen()));
  }

  Widget _setUpScreen() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.33.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 7.h,
          ),
          SizedBox(height: 12.h),
          Text(
            "Let’s setup your account!",
            style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize:
                    SizerUtil.deviceType == DeviceType.tablet ? 20.sp : 28.sp),
          ),
          SizedBox(height: 3.h),
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Text(
              "Account can be your bank, credit card or your wallet.",
              style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500,
                  fontSize:
                      SizerUtil.deviceType == DeviceType.tablet ? 9.sp : 11.sp),
            ),
          ),
          SizedBox(height: 5.h),
          const Spacer(),
          CommonButton(
              onTap: () {
                setState(() {
                  _setUpScreens = false;
                });
              },
              title: StringRes.letsGo),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }

  Widget _addAccountScreen() {
    return Container(
      color: AppColors.buttonColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 7.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.33.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: CommonBackButton(
                      color: AppColors.whiteTextColor,
                    )),
                Text(
                  StringRes.addNewAccount,
                  style: TextStyle(
                      color: AppColors.whiteTextColor,
                      fontSize: StringRes.appBarTitle.fontSize,
                      fontWeight: StringRes.appBarTitle.fontWeight),
                )
              ],
            ),
          ),
          const Spacer(),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.33.w),
            child: Text(
              StringRes.balance,
              style: TextStyle(
                  color: AppColors.whiteTextColor.withOpacity(0.80),
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp),
            ),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.33.w),
            child: TextField(
              controller: _amountController,
              style: TextStyle(
                fontSize: 36.sp,
                color: AppColors.whiteTextColor,
                fontWeight: FontWeight.w700,
              ),
              keyboardType: TextInputType.number,
              cursorColor: AppColors.whiteTextColor,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: "0",
                hintStyle: TextStyle(
                  fontSize: 36.sp,
                  color: AppColors.whiteTextColor,
                  fontWeight: FontWeight.w700,
                ),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 0, minHeight: 0),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Text(
                    "\$",
                    style: TextStyle(
                      fontSize: 36.sp,
                      color: AppColors.whiteTextColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 1.2.h),
          Container(
            padding: EdgeInsets.only(
                left: 5.33.w, right: 5.33.w, bottom: 5.h, top: 3.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  hintText: "Name",
                  controller: _nameController,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Please enter name";
                    }
                    else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 2.h),
                CustomDropDownField(
                  title: "Account Type",
                  selectedValue:
                      _selectAccountType.isEmpty ? null : _selectAccountType,
                  itemList: ["Saving", "Current", "Other"],
                  onChange: (val) {
                    _selectAccountType = val!;
                  },
                ),
                SizedBox(height: 2.h),
                Text(
                  "Bank",
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp),
                ),
                SizedBox(height: 1.5.h),
                GridView.count(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    childAspectRatio: 1.8,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ...bankImageList
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectBank = e;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 1.w, vertical: 1.w),
                                decoration: BoxDecoration(
                                    color: _selectBank == e
                                        ? const Color(0xFFEEE5FF)
                                        : const Color(0xFFF1F1FA),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: _selectBank == e
                                            ? AppColors.buttonColor
                                            : const Color(0xFFF1F1FA))),
                                alignment: Alignment.center,
                                child: Image.asset(e,
                                    height: SizerUtil.deviceType ==
                                            DeviceType.tablet
                                        ? 4.h
                                        : 2.6.h,
                                    width: SizerUtil.deviceType ==
                                            DeviceType.tablet
                                        ? 18.w
                                        : 12.w),
                              ),
                            ),
                          )
                          .toList(),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 1.w, vertical: 1.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEE5FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "See Other",
                          style: TextStyle(
                              color: AppColors.buttonColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 9.5.sp),
                        ),
                      ),
                    ]),
                SizedBox(height: 2.h),
                CommonButton(
                    onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (_selectAccountType.isNotEmpty) {
                            if (_selectBank.isNotEmpty) {
                              if (_amountController.text.isNotEmpty) {
                                Provider.of<AppDataStore>(context,
                                        listen: false)
                                    .addNewAccount(
                                  AccountModel(
                                    id: DateTime.now().microsecondsSinceEpoch,
                                    accName: _nameController.text,
                                    accIcon: _selectBank,
                                    accType: _selectAccountType,
                                    accBalance:
                                        double.parse(_amountController.text),
                                  ),
                                );
                                setState(() {
                                  _allSets = true;
                                });
                                Future.delayed(Duration(seconds: 1),(){
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/dashBoard", (route) => false);
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please enter amount");
                              }
                            } else {
                              Fluttertoast.showToast(msg: "Please select Bank");
                            }
                          }
                        }
                    },
                    title: StringRes.continues),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _allSet() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(StringRes.allSetIcon, height: 10.h),
          SizedBox(height: 2.h),
          Text(
            "You are set!",
            style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  List<String> bankImageList = [
    StringRes.bank1Icon,
    StringRes.paypalIcon,
    StringRes.citiBankIcon,
    StringRes.bank2Icon,
    StringRes.bank3Icon,
    StringRes.mandiriBankIcon,
    StringRes.bcaBankIcon,
  ];
}
