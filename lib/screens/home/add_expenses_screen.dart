import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:expense_tracker/Utils/size_utils.dart';
import 'package:expense_tracker/model/account_model.dart';
import 'package:expense_tracker/model/income_expense_model.dart';
import 'package:expense_tracker/provider/appdata_store_provider.dart';
import 'package:expense_tracker/widgets/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helper/image_and_file_picker.dart';
import '../../res/app_colors.dart';
import '../../res/strings.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down_field.dart';
import '../../widgets/custom_text_field.dart';

class AddExpensesScreen extends StatefulWidget {
  const AddExpensesScreen({Key? key}) : super(key: key);

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final ValueNotifier<bool> _repeat = ValueNotifier(false);
  final ValueNotifier<bool> _setRepeat = ValueNotifier(false);
  final ValueNotifier<File> _selectImage = ValueNotifier(File(''));
  final ValueNotifier<DateTime> selectDate = ValueNotifier(DateTime.now());
  final _formKey = GlobalKey<FormState>();
  List<String> accountList = [];
  bool _isIncomeView = false;
  bool _isCreateView = true;
  String _selectCategory = '';
  String _selectAccount = '';

  @override
  Widget build(BuildContext context) {
    accountList.clear();
    Provider
        .of<AppDataStore>(context, listen: false)
        .accountList
        .forEach((element) {
      accountList.add(element.accName!);
    });
    IncomeExpenseModel model = ModalRoute
        .of(context)!
        .settings
        .arguments as IncomeExpenseModel;
    if (model.id != null) {
      _isCreateView = false;
      _amountController.text = model.balance!.toString();
      _selectCategory = model.category!;
      _selectAccount = model.account!.accName!;
      _repeat.value = model.repeat!;
      _setRepeat.value = model.repeat!;
      _descriptionController.text = model.description!;
      if (model.image != null && model.image!.isNotEmpty) {
        print("===>>>>>>>>> ${model.image}");
        _selectImage.value = File("${Provider
            .of<AppDataStore>(context, listen: false)
            .appDirectoryPath}/image${model.id}.png");
      }
    }
    if (model.type == StringRes.income) {
    _isIncomeView = true;
    }
    return Scaffold(
      body: _addAccountScreen(model),
    );
  }

  Widget _addAccountScreen(IncomeExpenseModel model) {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraint.maxHeight,
          ),
          child: IntrinsicHeight(
            child: Form(
              key: _formKey,
              child: Container(
                color:_isIncomeView
                    ? const Color(0xFF00A86B)
                    : const Color(0xFFFD3C4A),
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
                            model.type!,
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
                        "How much?",
                        style: TextStyle(
                            color: AppColors.whiteTextColor.withOpacity(0.80),
                            fontWeight: FontWeight.w500,
                            fontSize: SizeUtil.f14),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.33.w),
                      child: TextField(
                        controller: _amountController,
                        style: TextStyle(
                          fontSize: SizerUtil.deviceType == DeviceType.tablet
                              ? 30.sp
                              : 36.sp,
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
                            fontSize: SizerUtil.deviceType == DeviceType.tablet
                                ? 30.sp
                                : 36.sp,
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
                                fontSize:
                                SizerUtil.deviceType == DeviceType.tablet
                                    ? 30.sp
                                    : 36.sp,
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
                          left: 5.33.w, right: 5.33.w, bottom: 4.h, top: 3.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomDropDownField(
                              title: "Category",
                              selectedValue: _selectCategory.isEmpty ? null : _selectCategory,
                              onChange: (val) {
                                _selectCategory = val!;
                              },
                              itemList: _isIncomeView
                                  ? ["Salary", "Passive Income", "Other"]
                                  : [
                                "Shopping",
                                "Subscription",
                                "Food",
                                "Transportation",
                                "Other"
                              ]),
                          SizedBox(height: 2.h),
                          CustomTextField(
                            hintText: "Description",
                            controller: _descriptionController,
                          ),
                          SizedBox(height: 2.h),
                          CustomDropDownField(
                              title: "Wallet",
                              itemList: accountList,
                              selectedValue: _selectAccount.isEmpty ? null : _selectAccount,
                              onChange: (val) {
                                _selectAccount = val!;
                              }),
                          SizedBox(height: 2.h),
                          ValueListenableBuilder(
                              valueListenable: _selectImage,
                              builder: (context, File selectedValue, child) {
                                return _selectImage.value.path.isNotEmpty
                                    ? imageWidget()
                                    : GestureDetector(
                                  onTap: () {
                                    showBottomSheet(context);
                                  },
                                  child: DottedBorder(
                                    color:
                                    const Color.fromRGBO(241, 241, 250, 1),
                                    strokeWidth: 1.2,
                                    radius: Radius.circular(20),
                                    dashPattern: [10, 7],
                                    borderType: BorderType.RRect,
                                    child: Container(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 2.h),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Image.asset(StringRes.attachIcon,
                                              height: SizerUtil.deviceType ==
                                                  DeviceType.tablet
                                                  ? 10.sp
                                                  : 15.sp),
                                          SizedBox(width: 4.w),
                                          Text(
                                            "Add attachment",
                                            style: TextStyle(
                                                color: const Color(0xFF91919F),
                                                fontWeight: FontWeight.w400,
                                                fontSize: SizeUtil.f13),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),

                          SizedBox(height: 2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Repeat",
                                    style: TextStyle(
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeUtil.f13),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Text(
                                    "Repeat transaction",
                                    style: TextStyle(
                                        color: const Color(0xFF91919F),
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeUtil.f10),
                                  ),
                                ],
                              ),
                              ValueListenableBuilder(
                                  valueListenable: _repeat,
                                  builder: (context, bool selectedValue,
                                      child) {
                                    return CupertinoSwitch(
                                        value: selectedValue,
                                        onChanged: (val) {
                                          _repeat.value = !_repeat.value;
                                          _setRepeat.value = _repeat.value;
                                          if (_repeat.value) {
                                            showRepeatTransactionBottomSheet(
                                                context);
                                          }
                                        },
                                        activeColor: AppColors.buttonColor,
                                        trackColor: const Color(0xFFEEE5FF));
                                  }
                              ),
                            ],
                          ),
                          ValueListenableBuilder(
                              valueListenable: _setRepeat,
                              builder: (context, bool selectedValue, child) {
                                return selectedValue
                                    ? Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Frequency",
                                              style: TextStyle(
                                                  color:
                                                  AppColors.textColor,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  fontSize: SizeUtil.f12),
                                            ),
                                            SizedBox(height: 0.5.h),
                                            Text(
                                              "Yearly - December 29",
                                              style: TextStyle(
                                                  color: const Color(
                                                      0xFF91919F),
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  fontSize: SizeUtil.f10),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "End After",
                                              style: TextStyle(
                                                  color:
                                                  AppColors.textColor,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  fontSize: SizeUtil.f12),
                                            ),
                                            SizedBox(height: 0.5.h),
                                            Text(
                                              "29 December 2025",
                                              style: TextStyle(
                                                  color: const Color(
                                                      0xFF91919F),
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  fontSize: SizeUtil.f10),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showRepeatTransactionBottomSheet(
                                              context);
                                        },
                                        child: Chip(
                                          backgroundColor:
                                          Color(0xFFEEE5FF),
                                          label: Text(
                                            " ${StringRes.edit} ",
                                            style: TextStyle(
                                                fontSize: SizeUtil.f9,
                                                color:
                                                AppColors.buttonColor,
                                                fontWeight:
                                                FontWeight.w500),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                                    : const SizedBox();
                              }),
                          SizedBox(height: 3.h),
                          CommonButton(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (_selectCategory != '' &&
                                      _selectAccount != '') {
                                    if (_amountController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Please enter amount");
                                    } else {
                                      AccountModel accountModel = AccountModel();
                                      Provider
                                          .of<AppDataStore>(context,
                                          listen: false)
                                          .accountList
                                          .forEach((element) {
                                        if (element.accName == _selectAccount) {
                                          accountModel = element;
                                        }
                                      });
                                      int id =
                                          DateTime
                                              .now()
                                              .microsecondsSinceEpoch;
                                      String imagePath = '';
                                      if (_selectImage.value.path.isNotEmpty) {
                                        imagePath =
                                        await saveImage(id, _selectImage.value);
                                      }
                                      IncomeExpenseModel newModel =
                                      IncomeExpenseModel(
                                          id: _isCreateView ? id : model.id,
                                          balance: double.parse(
                                              _amountController.text),
                                          category: _selectCategory,
                                          description:
                                          _descriptionController.text,
                                          endAfter: "",
                                          repeat: _repeat.value,
                                          frequency: "",
                                          image: imagePath,
                                          account: accountModel);

                                      if(_isCreateView){
                                        Provider.of<AppDataStore>(context,
                                            listen: false)
                                            .updateAccountBalance(accountModel,
                                            action: _isIncomeView
                                                ? BalanceAction.add
                                                : BalanceAction.remove,
                                            amount: double.parse(
                                                _amountController.text));
                                      }else {
                                        Provider.of<AppDataStore>(context,
                                            listen: false)
                                            .updateAccountBalance(accountModel,
                                            action: _isIncomeView
                                                ? BalanceAction.add
                                                : BalanceAction.remove,
                                            amount: double.parse(
                                                _amountController.text) - model.balance!);
                                      }

                                      if (_isIncomeView) {
                                        newModel.type = StringRes.income;
                                        if(!_isCreateView){
                                          Provider.of<AppDataStore>(context,
                                              listen: false)
                                              .removeIncomeItem(newModel);
                                        }
                                        Provider.of<AppDataStore>(context,
                                            listen: false)
                                            .addIncomeItem(newModel);
                                        Navigator.pop(context);
                                      } else {
                                        newModel.type = StringRes.expense;
                                        if(!_isCreateView){
                                          Provider.of<AppDataStore>(context,
                                              listen: false)
                                              .removeExpenseItem(newModel);
                                        }
                                        Provider.of<AppDataStore>(context,
                                            listen: false)
                                            .addExpenseItem(newModel);
                                        Provider.of<AppDataStore>(context,
                                            listen: false).updateBudget(newModel);
                                        Navigator.pop(context);
                                      }
                                    }
                                  }
                                  //showSuccessDialog();
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
          ),
        ),
      );
    });
  }

  /// image widget
  Widget imageWidget() {
    return SizedBox(
      height: 125,
      width: 125,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    fit: BoxFit.cover, image: FileImage(_selectImage.value))),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
                onTap: () {
                  _selectImage.value = File('');
                },
                child: Image.asset(StringRes.closeIcon, height: 24, width: 24)),
          ),
        ],
      ),
    );
  }

  /// bottom sheet
  Future showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
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
                  height: 5.h,
                ),
                Row(
                  children: [
                    SizedBox(width: 2.w),
                    _bottomSheetItem(
                        name: StringRes.camera, icon: StringRes.cameraIcon),
                    _bottomSheetItem(
                        name: StringRes.image, icon: StringRes.galleryIcon),
                    _bottomSheetItem(
                        name: StringRes.document, icon: StringRes.fileIcon),
                    SizedBox(width: 2.w),
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

  /// bottom sheet item
  Widget _bottomSheetItem({required String name, required String icon}) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () async {
          Navigator.pop(context);
          if (name == StringRes.camera) {
            _selectImage.value =
                await HelperFunctions.selectCameraImage() ?? File('');
          } else if (name == StringRes.image) {
            _selectImage.value =
                await HelperFunctions.selectGalleryImage() ?? File('');
          } else if (name == StringRes.document) {
            _selectImage.value = await HelperFunctions.selectFile() ?? File('');
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.5.w),
          padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
              color: Color(0xFFEEE5FF),
              borderRadius: BorderRadius.circular(16)),
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.asset(icon, height: 32, width: 32),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                name,
                style: TextStyle(
                    color: AppColors.buttonColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// repeat transaction bottom sheet
  Future showRepeatTransactionBottomSheet(BuildContext context) {
    var dateFormat = DateFormat('dd MMM yyyy');
    final ValueNotifier<bool> isFrequency = ValueNotifier(false);
    final ValueNotifier<bool> isEndAfter = ValueNotifier(false);
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
                topLeft: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width: 35,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Color(0xFFD3BDFF),
                      borderRadius: BorderRadius.circular(30)),
                ),
                SizedBox(
                  height: 3.h,
                ),
                ValueListenableBuilder(
                    valueListenable: isFrequency,
                    builder: (context, bool selectedValue, child) {
                      return selectedValue
                          ? Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: _dropDownField(title: "Year")),
                          SizedBox(width: 2.5.w),
                          Expanded(
                              flex: 1,
                              child: _dropDownField(title: "Dec")),
                          SizedBox(width: 2.5.w),
                          Expanded(
                              flex: 1,
                              child: _dropDownField(title: "29")),
                        ],
                      )
                          : _dropDownField(
                        title: "Frequency",
                        onTap: () {
                          isFrequency.value = !isFrequency.value;
                        },
                      );
                    }),
                SizedBox(
                  height: 2.h,
                ),
                ValueListenableBuilder(
                    valueListenable: isEndAfter,
                    builder: (context, bool selectedValue, child) {
                      return selectedValue
                          ? Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: _dropDownField(title: "Date")),
                          SizedBox(width: 2.5.w),
                          Expanded(
                            flex: 1,
                            child: ValueListenableBuilder(
                                valueListenable: selectDate,
                                builder: (context, DateTime selectedValue,
                                    child) {
                                  return _dropDownField(
                                      title: dateFormat.format(
                                        selectedValue,
                                      ),
                                      onTap: () => datePicker());
                                }),
                          ),
                        ],
                      )
                          : _dropDownField(
                        title: "End After",
                        onTap: () {
                          isEndAfter.value = !isEndAfter.value;
                        },
                      );
                    }),
                SizedBox(
                  height: 2.h,
                ),
                CommonButton(
                    onTap: () {
                      _setRepeat.value = true;
                      Navigator.pop(context);
                    },
                    title: StringRes.next),
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
                    "Transaction has been successfully added",
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

  /// date picker
  Future datePicker() {
    DateTime _selectDate = DateTime.now();
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.2.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF91919F),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            selectDate.value = _selectDate;
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.buttonColor,
                            ),
                          ),
                        )
                      ]),
                ),
                SizedBox(
                    height: 32.h,
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime newdate) {
                        _selectDate = newdate;
                        print(newdate);
                      },
                      use24hFormat: true,
                      maximumDate:
                      DateTime.now().add(const Duration(days: 3650)),
                      minimumYear: DateTime
                          .now()
                          .year - 10,
                      maximumYear: DateTime
                          .now()
                          .year + 10,
                      minuteInterval: 1,
                      mode: CupertinoDatePickerMode.date,
                    )),
              ],
            ),
          );
        });
  }

  Widget _dropDownField({required String title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Color.fromRGBO(241, 241, 250, 1),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: const Color(0xFF91919F),
                  fontWeight: FontWeight.w400,
                  fontSize: SizeUtil.f13),
            ),
            Image.asset(
              StringRes.arrowDownIcon,
              height: 6.sp,
              color: const Color(0xFF91919F),
            ),
          ],
        ),
      ),
    );
  }

  /// save local image
  Future<String> saveImage(int id, File image) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    print("==>>>> ${appDocPath}");
    final File saveImage = await image.copy('$appDocPath/image$id.png');
    return saveImage.path;
  }
}
