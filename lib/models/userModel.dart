// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
  UserModel({
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.fathername,
    @required this.address,
  });

  String id;
  String name;
  String phone;
  String fathername;
  String address;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        fathername: json["fathername"] == null ? null : json["fathername"],
        address: json["address"] == null ? null : json["address"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "fathername": fathername == null ? null : fathername,
        "address": address == null ? null : address,
      };
}
