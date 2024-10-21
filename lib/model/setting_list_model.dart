import 'dart:convert';

List<SettingListModel> settingListModelFromJson(String str) => List<SettingListModel>.from(json.decode(str).map((x) => SettingListModel.fromJson(x)));

String settingListModelToJson(List<SettingListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SettingListModel {
  SettingListModel({
    this.title,
    this.selectIndex,
    this.values,
    this.id
  });

  int? id;
  String? title;
  int? selectIndex;
  List<String>? values;

  factory SettingListModel.fromJson(Map<String, dynamic> json) => SettingListModel(
    id: json["id"] ?? 0,
    title: json["title"] ?? '',
    selectIndex: json["select_index"] ?? 0,
    values: json["values"] == null ? null : List<String>.from(json["values"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id ?? 0,
    "title": title ?? '',
    "select_index": selectIndex ?? 0,
    "values": values == null ? null : List<dynamic>.from(values!.map((x) => x)),
  };
}
