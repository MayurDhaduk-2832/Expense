import 'package:expense_tracker/Utils/size_utils.dart';
import 'package:expense_tracker/model/account_model.dart';
import 'package:expense_tracker/widgets/back_button.dart';
import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/appdata_store_provider.dart';
import '../../res/app_colors.dart';
import '../../res/strings.dart';

class AccountDetailScreen extends StatefulWidget {
  const AccountDetailScreen({Key? key}) : super(key: key);

  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AppDataStore>(
        builder: (context,model,widget) {
          double totalBalance = 0;
          model.accountList.forEach((element) {
            totalBalance = totalBalance + element.accBalance!;
          });
          return Column(
            children: [
              SizedBox(
                height: 7.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.33.w, right: 2.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child:CommonBackButton()
                    ),
                    Text(
                      StringRes.account,
                      style: StringRes.appBarTitle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    StringRes.accountBGImage,
                    width: 100.w,
                    height: SizerUtil.deviceType == DeviceType.tablet ? 33.h : 28.h,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    children: [
                      Text(
                        "Account Balance",
                        style: TextStyle(
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeUtil.f10),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "\$$totalBalance",
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: SizerUtil.deviceType == DeviceType.tablet ? 25.sp : 30.sp),
                      ),
                    ],
                  ),
                ],
              ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context,index){
                  return _item(model.accountList[index]);
              },
                  separatorBuilder: (context,index){
                    return const Divider(height: 0,);
                  },
                  itemCount: model.accountList.length),

            ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.2.w),
                child: CommonButton(onTap: (){
                  Navigator.pushNamed(context, '/addEditAccount');
                }, title: "+ Add new wallet"),
              ),
              SizedBox(
                height: 4.h,
              ),
            ],
          );
        }
      ),
    );
  }

  Widget _item(AccountModel model) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/addEditAccount',arguments: model);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.8.h),
        color: Colors.transparent,
        child: Row(children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1FA),
              borderRadius: BorderRadius.circular(16)
            ),
            padding: EdgeInsets.all(10),
            child: Image.asset(model.accIcon!, height: SizerUtil.deviceType == DeviceType.tablet ?  45 : 24,width:SizerUtil.deviceType == DeviceType.tablet ? 45 : 24),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              model.accName!,
              style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeUtil.f12),
            ),
          ), Text(
            "\$${model.accBalance}",
            style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
                fontSize: SizeUtil.f12),
          ),
        ]),
      ),
    );
  }
}
