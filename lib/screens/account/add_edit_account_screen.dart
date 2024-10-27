import 'package:expense_tracker/model/account_model.dart';
import 'package:expense_tracker/provider/appdata_store_provider.dart';
import 'package:expense_tracker/widgets/back_button.dart';
import 'package:expense_tracker/widgets/custom_drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../res/app_colors.dart';
import '../../res/strings.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class AddEditAccountScreen extends StatefulWidget {
  const AddEditAccountScreen({super.key});

  @override
  State<AddEditAccountScreen> createState() => _AddEditAccountScreenState();
}

class _AddEditAccountScreenState extends State<AddEditAccountScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectAccountType = '';
  String _selectBank = '';
  final _formKey = GlobalKey<FormState>();
  List<String> bankImageList = [
    StringRes.bank1Icon,
    StringRes.paypalIcon,
    StringRes.citiBankIcon,
    StringRes.bank2Icon,
    StringRes.bank3Icon,
    StringRes.mandiriBankIcon,
    StringRes.bcaBankIcon,
  ];

  @override
  Widget build(BuildContext context) {
    bool editView = false;
    AccountModel model = AccountModel();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      editView = true;
      model = ModalRoute.of(context)!.settings.arguments as AccountModel;
      _nameController.text = model.accName!;
      _selectAccountType = model.accType!;
      _selectBank = model.accIcon!;
      _amountController.text = model.accBalance!.toString();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: AppColors.buttonColor,
        child: Form(
          key: _formKey,
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
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: CommonBackButton(
                        color: AppColors.whiteTextColor,
                      ),
                    ),
                    Text(
                      editView
                          ? StringRes.editAccount
                          : StringRes.addNewAccount,
                      style: TextStyle(
                          color: AppColors.whiteTextColor,
                          fontSize: StringRes.appBarTitle.fontSize,
                          fontWeight: StringRes.appBarTitle.fontWeight),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AppDataStore>(context, listen: false)
                              .removeAccount(model);
                          Navigator.pop(context);
                        },
                        child: Image.asset(StringRes.deleteIcon,
                            height: Device.screenType == ScreenType.tablet
                                ? 45
                                : 30,
                            color: AppColors.whiteTextColor),
                      ),
                    ),
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
                    fontSize: 32.sp,
                    color: AppColors.whiteTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.number,
                  cursorColor: AppColors.whiteTextColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: "0.00",
                    hintStyle: TextStyle(
                      fontSize: 32.sp,
                      color: AppColors.whiteTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIconConstraints:
                        const BoxConstraints(minWidth: 0, minHeight: 0),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Text(
                        "\$",
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: AppColors.whiteTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.2.h),
              Container(
                padding: EdgeInsets.only(
                    left: 5.33.w, right: 5.33.w, bottom: 4.h, top: 3.h),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      hintText: "Name",
                      controller: _nameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 2.h),
                    CustomDropDownField(
                      title: "Account Type",
                      selectedValue: _selectAccountType.isEmpty
                          ? null
                          : _selectAccountType,
                      itemList: const ["Saving", "Current", "Other"],
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
                          ...bankImageList.map(
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
                                    height:
                                        Device.screenType == ScreenType.tablet
                                            ? 4.h
                                            : 2.6.h,
                                    width:
                                        Device.screenType == ScreenType.tablet
                                            ? 18.w
                                            : 12.w),
                              ),
                            ),
                          ),
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
                            if (_selectAccountType != '') {
                              if (_selectBank != '') {
                                if (_amountController.text != '') {
                                  if (editView) {
                                    Provider.of<AppDataStore>(context,
                                            listen: false)
                                        .removeAccount(model);
                                    Provider.of<AppDataStore>(context,
                                            listen: false)
                                        .addNewAccount(
                                      AccountModel(
                                        id: model.id,
                                        accName: _nameController.text,
                                        accIcon: _selectBank,
                                        accType: _selectAccountType,
                                        accBalance: double.parse(
                                            _amountController.text),
                                      ),
                                    );
                                  } else {
                                    Provider.of<AppDataStore>(context,
                                            listen: false)
                                        .addNewAccount(
                                      AccountModel(
                                        id: DateTime.now()
                                            .microsecondsSinceEpoch,
                                        accName: _nameController.text,
                                        accIcon: _selectBank,
                                        accType: _selectAccountType,
                                        accBalance: double.parse(
                                            _amountController.text),
                                      ),
                                    );
                                  }
                                  Navigator.pop(context);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please enter amount");
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please select Bank");
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
        ),
      ),
    );
  }
}
