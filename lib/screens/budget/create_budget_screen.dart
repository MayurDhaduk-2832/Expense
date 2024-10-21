import 'package:expense_tracker/Utils/size_utils.dart';
import 'package:expense_tracker/model/budget_model.dart';
import 'package:expense_tracker/model/income_expense_model.dart';
import 'package:expense_tracker/provider/appdata_store_provider.dart';
import 'package:expense_tracker/widgets/back_button.dart';
import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:expense_tracker/widgets/custom_drop_down_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../res/app_colors.dart';
import '../../res/strings.dart';

class CreateBudgetScreen extends StatefulWidget {
  const CreateBudgetScreen({Key? key}) : super(key: key);

  @override
  State<CreateBudgetScreen> createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends State<CreateBudgetScreen> {
  final ValueNotifier<bool> _receiveAlert = ValueNotifier(false);
  final ValueNotifier<double> _sliderValue = ValueNotifier(20.00);
  final TextEditingController _amountController = TextEditingController();
  String _selectCategory = '';
  @override
  Widget build(BuildContext context) {
    BudgetModel model = BudgetModel();
    bool isCreateBudget = true;
    if(ModalRoute.of(context)!.settings.arguments != null){
      isCreateBudget = false;
      model = ModalRoute.of(context)!.settings.arguments as BudgetModel;
      _amountController.text = model.balance!.toString();
      _selectCategory = model.category!;
      _receiveAlert.value = model.alert!;
      if(_receiveAlert.value){
        _sliderValue.value = model.alertValue!.toDouble();
      }
    }
    return Scaffold(
      backgroundColor: AppColors.buttonColor,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
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
                    child: CommonBackButton(color: AppColors.whiteTextColor),
                  ),
                  Text(
                    isCreateBudget ? StringRes.creteBudget : StringRes.editBudget,
                    style: TextStyle(
                        color: AppColors.whiteTextColor,
                        fontSize: StringRes.appBarTitle.fontSize,
                        fontWeight: StringRes.appBarTitle.fontWeight),
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.2.w),
              child: Text(
                "How much do yo want to spend?",
                style: TextStyle(
                    color: AppColors.whiteTextColor.withOpacity(0.64),
                    fontWeight: FontWeight.w500,
                    fontSize: SizeUtil.f11),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.2.w),
              child: TextField(
                controller: _amountController,
                style: TextStyle(fontSize: 32.sp, color: AppColors.whiteTextColor,fontWeight: FontWeight.w500,),
                keyboardType: TextInputType.number,
                cursorColor:AppColors.whiteTextColor,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: "0",
                  hintStyle: TextStyle(fontSize: 32.sp, color: AppColors.whiteTextColor,fontWeight: FontWeight.w500,),
                  prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Text("\$", style: TextStyle(fontSize: 32.sp, color: AppColors.whiteTextColor,fontWeight: FontWeight.w500,),),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.2.w,vertical: 2.5.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24),
                  topLeft: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomDropDownField(
                      title: "Category",
                      selectedValue: _selectCategory.isEmpty ? null : _selectCategory,
                      onChange: (val) {
                        _selectCategory = val!;
                      },
                      itemList: Provider.of<AppDataStore>(context,listen: true).categoryList),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Receive Alert",
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeUtil.f13),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            "Receive alert when it reaches some point.",
                            style: TextStyle(
                                color: const Color(0xFF91919F),
                                fontWeight: FontWeight.w500,
                                fontSize: SizeUtil.f10),
                          ),
                        ],
                      ),
                      ValueListenableBuilder(
                          valueListenable: _receiveAlert,
                          builder: (context, bool selectedValue, child) {
                            return CupertinoSwitch(
                              value: _receiveAlert.value,
                              onChanged: (val) {
                                _receiveAlert.value = !_receiveAlert.value;
                              },
                              activeColor: AppColors.buttonColor,
                              trackColor: const Color(0xFFEEE5FF));
                        }
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  ValueListenableBuilder(
                      valueListenable: _sliderValue,
                      builder: (context, double selectedValue, child) {
                        return _receiveAlert.value ? SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: AppColors.buttonColor,
                            inactiveTrackColor: Color(0xFFE3E5E5),
                            trackShape: RoundedRectSliderTrackShape(),
                            trackHeight: 10.0,
                            thumbShape: CustomSliderThumbCircle(thumbRadius: 20.0),
                            tickMarkShape: RoundSliderTickMarkShape(),
                            activeTickMarkColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            showValueIndicator: ShowValueIndicator.never,
                          ),
                          child: Slider(
                            value: selectedValue,
                            min: 0,
                            max: 100,
                            divisions: 100,
                            onChanged: (value) {
                              _sliderValue.value = value;
                            },
                          ),
                        ) : const SizedBox();
                    }
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CommonButton(onTap: (){
                    if(_amountController.text.isEmpty){
                      Fluttertoast.showToast(msg: "Please enter amount");
                    }else{
                      if(_selectCategory.isEmpty){
                        Fluttertoast.showToast(msg: "Please select category");
                      }else{
                        if(isCreateBudget){
                          if(Provider.of<AppDataStore>(context,listen: false).budgetList.any((element) => element.category == _selectCategory)){
                            Fluttertoast.showToast(msg: "Already exit this category");
                          }else {
                            List<IncomeExpenseModel> list = [];
                            Provider.of<AppDataStore>(context,listen: false).expenseDataList.forEach((element) {
                              if(element.category == _selectCategory){
                                list.add(element);
                              }
                            });
                            Provider.of<AppDataStore>(context,listen: false).addBudgetItem(BudgetModel(
                                id: DateTime.now().microsecondsSinceEpoch,
                                balance: double.parse(_amountController.text),
                                category: _selectCategory,
                                categories: list,
                                alert: _receiveAlert.value,
                                alertValue: _sliderValue.value.toInt()
                            ));
                            Navigator.pop(context);
                          }
                        }else{
                          Provider.of<AppDataStore>(context,listen: false).removeBudgetItem(model);
                          Provider.of<AppDataStore>(context,listen: false).addBudgetItem(BudgetModel(
                              id: model.id,
                              balance: double.parse(_amountController.text),
                              category: _selectCategory,
                              categories: model.categories,
                              alert: _receiveAlert.value,
                              alertValue: _sliderValue.value.toInt()
                          ));
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      }
                    }
                  }, title: StringRes.continues),
                  SizedBox(
                    height: 1.5.h,
                  ),
                ],
              ),
            ),

          ],
        ),
    );
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;

  const CustomSliderThumbCircle({
    required this.thumbRadius,
    this.min = 0,
    this.max = 100,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        Animation<double>? activationAnimation,
        Animation<double>? enableAnimation,
        bool? isDiscrete,
        TextPainter? labelPainter,
        RenderBox? parentBox,
        SliderThemeData? sliderTheme,
        TextDirection? textDirection,
        double? value,
        double? textScaleFactor,
        Size? sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = AppColors.buttonColor //Thumb Background Color
      ..style = PaintingStyle.fill;

    TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: thumbRadius * .75,
        fontWeight: FontWeight.w700,
        color: AppColors.whiteTextColor, //Text Color of Value on Thumb
      ),
      text: getValue(value!),
    );

    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
    Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius * .9, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min+(max-min)*value).round().toString();
  }
}
