import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesConst {
  static late SharedPreferences _prefs;

  static Future initMySharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// set App Pin
  static Future<void> setAppPin(String pin) async {
    await _prefs.setString("appPin", pin);
  }

  /// get App Pin
  static String getsAppPin() {
    return _prefs.getString("appPin") ?? '';
  }

  /// set setting list
  static Future<void> setSettingList(String value) async {
    await _prefs.setString("settingList", value);
  }

  /// get setting list
  static String getSettingList() {
    return _prefs.getString("settingList") ?? '';
  }

  /// set account list
  static Future<void> setAccountList(String value) async {
    await _prefs.setString("accountList", value);
  }

  /// get account list
  static String getAccountList() {
    return _prefs.getString("accountList") ?? '';
  }

/// set income list
  static Future<void> setIncomeList(String value) async {
    await _prefs.setString("incomeList", value);
  }

  /// get income list
  static String getIncomeList() {
    return _prefs.getString("incomeList") ?? '';
  }

/// set account list
  static Future<void> setExpenseList(String value) async {
    await _prefs.setString("expenseList", value);
  }

  /// get account list
  static String getExpenseList() {
    return _prefs.getString("expenseList") ?? '';
  }
/// set budget list
  static Future<void> setBudgetList(String value) async {
    await _prefs.setString("budgetList", value);
  }

  /// get budget list
  static String getBudgetList() {
    return _prefs.getString("budgetList") ?? '';
  }
}