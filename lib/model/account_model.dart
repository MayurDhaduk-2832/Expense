import 'dart:convert';

List<AccountModel> accountModelFromJson(String str) => List<AccountModel>.from(
    json.decode(str).map((x) => AccountModel.fromJson(x)));

String accountModelToJson(List<AccountModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountModel {
  AccountModel({
    this.id,
    this.accName,
    this.accIcon,
    this.accBalance,
    this.accType,
  });

  int? id;
  String? accName;
  String? accIcon;
  double? accBalance;
  String? accType;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        id: json["id"],
        accName: json["acc_name"],
        accIcon: json["acc_icon"],
        accBalance: json["acc_balance"]?.toDouble(),
        accType: json["acc_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "acc_name": accName,
        "acc_icon": accIcon,
        "acc_balance": accBalance,
        "acc_type": accType,
      };
}
