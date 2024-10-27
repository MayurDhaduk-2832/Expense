// To parse this JSON data, do
//
//     final budgetModel = budgetModelFromJson(jsonString);

import 'dart:convert';

import 'package:expense_tracker/model/income_expense_model.dart';

List<BudgetModel> budgetModelFromJson(String str) => List<BudgetModel>.from(
    json.decode(str).map((x) => BudgetModel.fromJson(x)));

String budgetModelToJson(List<BudgetModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BudgetModel {
  BudgetModel(
      {this.id,
      this.category,
      this.balance,
      this.categories,
      this.alert,
      this.alertValue});

  int? id;
  bool? alert;
  int? alertValue;
  String? category;
  double? balance;
  List<IncomeExpenseModel>? categories;

  factory BudgetModel.fromJson(Map<String, dynamic> json) => BudgetModel(
        id: json["id"],
        alert: json["alert"],
        alertValue: json["alert_value"],
        category: json["category"],
        balance: json["balance"],
        categories: json["categories"] == null
            ? null
            : List<IncomeExpenseModel>.from(
                json["categories"].map((x) => IncomeExpenseModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alert": alert,
        "alert_value": alertValue,
        "category": category,
        "balance": balance,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}
