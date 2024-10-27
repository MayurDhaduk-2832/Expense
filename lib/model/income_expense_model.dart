import 'dart:convert';

import 'account_model.dart';

List<IncomeExpenseModel> incomeExpenseModelFromJson(String str) =>
    List<IncomeExpenseModel>.from(
        json.decode(str).map((x) => IncomeExpenseModel.fromJson(x)));

String incomeExpenseModelToJson(List<IncomeExpenseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IncomeExpenseModel {
  IncomeExpenseModel({
    this.id,
    this.type,
    this.category,
    this.balance,
    this.description,
    this.image,
    this.repeat,
    this.frequency,
    this.endAfter,
    this.account,
  });

  int? id;
  String? type;
  String? category;
  double? balance;
  String? description;
  String? image;
  bool? repeat;
  String? frequency;
  String? endAfter;
  AccountModel? account;

  factory IncomeExpenseModel.fromJson(Map<String, dynamic> json) =>
      IncomeExpenseModel(
        id: json["id"],
        type: json["type"],
        category: json["category"],
        balance: json["balance"],
        description: json["description"],
        image: json["image"],
        repeat: json["repeat"],
        frequency: json["frequency"],
        endAfter: json["end_after"],
        account: json["account"] == null
            ? null
            : AccountModel.fromJson(json["account"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "category": category,
        "balance": balance,
        "description": description,
        "image": image,
        "repeat": repeat,
        "frequency": frequency,
        "end_after": endAfter,
        "account": account?.toJson(),
      };
}
