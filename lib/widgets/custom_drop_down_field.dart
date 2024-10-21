import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expense_tracker/Utils/size_utils.dart';
import 'package:expense_tracker/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../res/strings.dart';

class CustomDropDownField extends StatelessWidget {
  final String title;
  String? selectedValue;
  Function(String?)? onChange;
  final List<String> itemList;
  CustomDropDownField({Key? key,required this.title,this.onChange,required this.itemList,this.selectedValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
          hintStyle: TextStyle(
              color: const Color(0xFF91919F),
              fontWeight: FontWeight.w400,
              fontSize: SizeUtil.f13),
          contentPadding: EdgeInsets.symmetric(vertical:SizerUtil.deviceType == DeviceType.tablet ? 2.2.h : 2.h,),
          enabledBorder: border,
          border: border,
          disabledBorder: border,
          errorBorder: border,
          focusedBorder: border,
          focusedErrorBorder: border
      ),
      isExpanded: true,
      hint: Text(
        title,
        style: TextStyle(fontSize: SizeUtil.f13),
      ),
      style: TextStyle(
          fontSize: SizeUtil.f13,
        color: AppColors.textColor
      ),
      icon: Padding(
        padding: EdgeInsets.only(right: 2.w),
        child: Image.asset(
          StringRes.arrowDownIcon,color:const Color(0xFF91919F),
          height: 6.sp,
        ),
      ),
      buttonPadding: EdgeInsets.only(left: SizerUtil.deviceType == DeviceType.tablet ? 3.w : 1.w, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      value: selectedValue,
      items: itemList
          .map((item) =>
          DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                fontSize: SizeUtil.f13,
              ),
            ),
          ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select $title';
        }
      },
      onChanged:onChange,
      onSaved: onChange,
    );
    //   GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     decoration: BoxDecoration(
    //       border: Border.all(width: 1, color: Color.fromRGBO(241, 241, 250, 1),),
    //       borderRadius: BorderRadius.circular(16),
    //     ),
    //     padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 5.w),
    //     alignment: Alignment.center,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           title,
    //           style: TextStyle(
    //               color: const Color(0xFF91919F),
    //               fontWeight: FontWeight.w400,
    //               fontSize: SizeUtil.f13),
    //         ),
    //         Image.asset(StringRes.arrowDownIcon,height: 6.sp,color:const Color(0xFF91919F),),
    //       ],
    //     ),
    //   ),
    // );
  }

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide:
    const BorderSide(width: 1, color: Color.fromRGBO(241, 241, 250, 1)),
  );

}
