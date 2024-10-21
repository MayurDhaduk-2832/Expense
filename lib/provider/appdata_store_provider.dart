import 'package:expense_tracker/helper/shared_pref_helper.dart';
import 'package:expense_tracker/model/account_model.dart';
import 'package:expense_tracker/model/budget_model.dart';
import 'package:flutter/material.dart';

import '../helper/image_and_file_picker.dart';
import '../model/income_expense_model.dart';
import '../model/setting_list_model.dart';

class AppDataStore extends ChangeNotifier {
  AppDataStore._internal();

  static final AppDataStore instance = AppDataStore._internal();
  List<SettingListModel> settingList = [];
  List<AccountModel> accountList = [];
  List<IncomeExpenseModel> incomeDataList = [];
  List<IncomeExpenseModel> expenseDataList = [];
  List<BudgetModel> budgetList = [];
  List<String> categoryList = [
    "Shopping",
    "Subscription",
    "Food",
    "Transportation",
    "Other"
  ];
  String appDirectoryPath = '';

  Future<void> initialize() async {
    if (SharedPreferencesConst.getSettingList() != '') {
      setSettingList(
        settingListModelFromJson(
          SharedPreferencesConst.getSettingList(),
        ),
      );
    } else {
      setSettingList(tempSettingList);
    }
    if (SharedPreferencesConst.getAccountList() != '') {
      accountList = accountModelFromJson(SharedPreferencesConst.getAccountList());
      notifyListeners();
    }
    if (SharedPreferencesConst.getIncomeList() != '') {
      incomeDataList = incomeExpenseModelFromJson(SharedPreferencesConst.getIncomeList());
      notifyListeners();
    }
    if (SharedPreferencesConst.getExpenseList() != '') {
      expenseDataList = incomeExpenseModelFromJson(SharedPreferencesConst.getExpenseList());
      notifyListeners();
    }
    if (SharedPreferencesConst.getBudgetList() != '') {
      budgetList = budgetModelFromJson(SharedPreferencesConst.getBudgetList());
      notifyListeners();
    }
    getAppDirectoryPath();
  }

  Future<void> getAppDirectoryPath() async {
    appDirectoryPath = await HelperFunctions.getPath();
    notifyListeners();
  }

  void setSettingList(List<SettingListModel> list) {
    settingList = list;
    SharedPreferencesConst.setSettingList(settingListModelToJson(list));
    notifyListeners();
  }
  void setSettingListValue(int index,int value) {
    settingList[index - 1].selectIndex = value;
    SharedPreferencesConst.setSettingList(settingListModelToJson(settingList));
    notifyListeners();
  }

  final List<SettingListModel> tempSettingList = [
    SettingListModel(id: 1, title: "Currency", selectIndex: 0, values: [
      "United Status (USD)",
      "Indonesia (IDR)",
      "Japan (JPY)",
      "Russia (RUB)",
      "Germany (EUR)",
      "Korea (WON)"
    ]),
    SettingListModel(id: 2, title: "Languages", selectIndex: 0, values: [
      "English (EN)",
      "Indonesian (ID)",
      "Arabic (AR)",
      "Chinese (ZH)",
      "Dutch (NL)",
      "French (FR)",
      "German (DE)",
      "Italian (IT)",
      "Korean (KO)",
      "Portuguese (PT)",
      "Russian (RU)",
      "Spanish (ES)"
    ]),
    SettingListModel(
        id: 3,
        title: "Theme",
        selectIndex: 0,
        values: ["Light", "Dark", "Use device theme"]),
    SettingListModel(
        id: 4,
        title: "Security",
        selectIndex: 0,
        values: ["PIN", "Fingerprint", "Face ID"]),
    SettingListModel(id: 5, title: "Notification", selectIndex: -1, values: []),
    SettingListModel(id: 6, title: "About", selectIndex: -1, values: []),
    SettingListModel(id: 7, title: "Help", selectIndex: -1, values: []),
  ];

  void addNewAccount(AccountModel model) {
    accountList.add(model);
    SharedPreferencesConst.setAccountList(accountModelToJson(accountList));
    notifyListeners();
  }

  void removeAccount(AccountModel model) {
    accountList.removeWhere((element) => element.id == model.id);
    SharedPreferencesConst.setAccountList(accountModelToJson(accountList));
    notifyListeners();
  }

  /// update amount
  void updateAccountBalance(AccountModel model,{required BalanceAction action,required double amount}) {
    int index = accountList.indexWhere((element) => element.id == model.id);
    if(action == BalanceAction.add){
      accountList[index].accBalance = accountList[index].accBalance! + amount;
    }else{
      accountList[index].accBalance = accountList[index].accBalance! - amount;
    }
    SharedPreferencesConst.setAccountList(accountModelToJson(accountList));
    notifyListeners();
  }

  /// add income List
  void addIncomeItem(IncomeExpenseModel model) {
    incomeDataList.add(model);
    SharedPreferencesConst.setIncomeList(incomeExpenseModelToJson(incomeDataList));
    notifyListeners();
  }

  /// remove income List
  void removeIncomeItem(IncomeExpenseModel model) {
    incomeDataList.removeWhere((element) => element.id == model.id);
    SharedPreferencesConst.setIncomeList(incomeExpenseModelToJson(incomeDataList));
    notifyListeners();
  }

  /// add expense List
  void addExpenseItem(IncomeExpenseModel model) {
    expenseDataList.add(model);
    SharedPreferencesConst.setExpenseList(incomeExpenseModelToJson(expenseDataList));
    notifyListeners();
  }

  /// remove expense List
  void removeExpenseItem(IncomeExpenseModel model) {
    expenseDataList.removeWhere((element) => element.id == model.id);
    SharedPreferencesConst.setExpenseList(incomeExpenseModelToJson(expenseDataList));
    notifyListeners();
  }

  /// add budget List
  void addBudgetItem(BudgetModel model) {
    budgetList.insert(0,model);
    SharedPreferencesConst.setBudgetList(budgetModelToJson(budgetList));
    notifyListeners();
  }

  /// remove budget List
  void removeBudgetItem(BudgetModel model) {
    budgetList.removeWhere((element) => element.id == model.id);
    SharedPreferencesConst.setBudgetList(budgetModelToJson(budgetList));
    notifyListeners();
  }

  /// update budget
  void updateBudget(IncomeExpenseModel model) {
    if(budgetList.any((element) => element.category == model.category)){
    int index = budgetList.indexWhere((element) => element.category == model.category);
    budgetList[index].categories!.removeWhere((index) => index.id == model.id);
    budgetList[index].categories!.add(model);
    SharedPreferencesConst.setBudgetList(budgetModelToJson(budgetList));
    }
    notifyListeners();
  }

 /// remove budget
  void removeBudgetData(IncomeExpenseModel model) {
    if(budgetList.any((element) => element.category == model.category)){
    int index = budgetList.indexWhere((element) => element.category == model.category);
    budgetList[index].categories!.removeWhere((index) => index.id == model.id);
    SharedPreferencesConst.setBudgetList(budgetModelToJson(budgetList));
    }
    notifyListeners();
  }

}

enum BalanceAction{
  add,
  remove
}
