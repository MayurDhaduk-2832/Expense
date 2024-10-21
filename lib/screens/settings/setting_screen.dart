import 'package:expense_tracker/Utils/size_utils.dart';
import 'package:expense_tracker/provider/appdata_store_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../model/setting_list_model.dart';
import '../../res/app_colors.dart';
import '../../res/strings.dart';
import '../../widgets/back_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 7.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.33.w,right: 2.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CommonBackButton(),
                ),
                Text(
                  StringRes.setting,
                  style: StringRes.appBarTitle,
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h,),
          const Divider(height: 0),

          Expanded(
            child: Consumer<AppDataStore>(
              builder: (context,model,widget) {
                return ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  itemCount: model.settingList.length,
                  itemBuilder: (context, index) {
                    return _item(model.settingList[index]);
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(height: index == 4 ? 7.h : 3.h,);
                  },
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(SettingListModel model) {
    return GestureDetector(
      onTap: (){
        if(model.id == 5){
          Navigator.pushNamed(context, "/setNotification");
        } else if(model.id == 6 || model.id == 7) {

        } else {
          Navigator.pushNamed(context, "/settingList",arguments: model);
        }

      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 4.8.w,vertical: 0.5.h),
        child: Row(
          children: [
            Expanded(
              child:Text(
                model.title!,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                    fontSize: SizeUtil.f12),
              ),
            ),
            Text(
              model.selectIndex == -1 ? '' : model.values![model.selectIndex!],
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF91919F),
                  fontSize: SizeUtil.f11),
            ),
            SizedBox(width: 1.w),
            RotationTransition(
              turns: const AlwaysStoppedAnimation(270 / 360),
              child: Image.asset(StringRes.arrowDownIcon, width: 14,height: 14),
            ),
          ],
        ),
      ),
    );
  }
}
