import 'package:expense_tracker/Utils/size_utils.dart';
import 'package:expense_tracker/provider/appdata_store_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../model/setting_list_model.dart';
import '../../res/app_colors.dart';
import '../../res/strings.dart';

class SettingListScreen extends StatefulWidget {
  const SettingListScreen({Key? key}) : super(key: key);

  @override
  State<SettingListScreen> createState() => _SettingListScreenState();
}

class _SettingListScreenState extends State<SettingListScreen> {

  @override
  Widget build(BuildContext context) {
    SettingListModel model = ModalRoute.of(context)!.settings.arguments as SettingListModel;
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
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(StringRes.backIcon, height: 16)),
                ),
                Text(
                  model.title!,
                  style: StringRes.appBarTitle,
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h,),
          const Divider(height: 0),

          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              itemCount: model.values!.length,
              itemBuilder: (context, index) {
                return _item(model.values![index],index);
              },
              separatorBuilder: (context,index){
                return SizedBox(height: 2.5.h,);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(String title,int index) {
    SettingListModel model = ModalRoute.of(context)!.settings.arguments as SettingListModel;
    return GestureDetector(
      onTap: (){
        model.selectIndex = index;
        Provider.of<AppDataStore>(context,listen: false).setSettingListValue(model.id!, index);
        setState(() {});
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 4.8.w,vertical: 0.1.h),
        child: Row(
          children: [
            Expanded(
              child:Padding(
                padding:  EdgeInsets.symmetric(vertical: 0.4.h),
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                      fontSize: SizeUtil.f12),
                ),
              ),
            ),
            model.selectIndex == index ? Image.asset(StringRes.allSetIcon,
              height: SizerUtil.deviceType == DeviceType.tablet ? 36 : 24,
              color: AppColors.buttonColor,) : const SizedBox()
          ],
        ),
      ),
    );
  }
}
