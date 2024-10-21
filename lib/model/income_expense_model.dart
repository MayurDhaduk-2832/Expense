import 'dart:convert';

import 'account_model.dart';

List<IncomeExpenseModel> incomeExpenseModelFromJson(String str) => List<IncomeExpenseModel>.from(json.decode(str).map((x) => IncomeExpenseModel.fromJson(x)));

String incomeExpenseModelToJson(List<IncomeExpenseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

  factory IncomeExpenseModel.fromJson(Map<String, dynamic> json) => IncomeExpenseModel(
    id: json["id"] == null ? null : json["id"],
    type: json["type"] == null ? null : json["type"],
    category: json["category"] == null ? null : json["category"],
    balance: json["balance"] == null ? null : json["balance"],
    description: json["description"] == null ? null : json["description"],
    image: json["image"] == null ? null : json["image"],
    repeat: json["repeat"] == null ? null : json["repeat"],
    frequency: json["frequency"] == null ? null : json["frequency"],
    endAfter: json["end_after"] == null ? null : json["end_after"],
    account: json["account"] == null ? null : AccountModel.fromJson(json["account"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "type": type == null ? null : type,
    "category": category == null ? null : category,
    "balance": balance == null ? null : balance,
    "description": description == null ? null : description,
    "image": image == null ? null : image,
    "repeat": repeat == null ? null : repeat,
    "frequency": frequency == null ? null : frequency,
    "end_after": endAfter == null ? null : endAfter,
    "account": account == null ? null : account?.toJson(),
  };
}

