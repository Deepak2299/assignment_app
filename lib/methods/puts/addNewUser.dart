import 'package:assignment_app/models/userModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<UserModel> addNewUser({
  @required String name,
  @required String phone,
  @required String fatherName,
  @required String address,
}) async {
  var body = {
    "name": name,
    "phone": phone,
    "fathername": fatherName,
    "address": address
  };
  UserModel userModel;
  var res = await http.post("https://temprestserver.herokuapp.com/tasks/",
      body: jsonEncode(body), headers: {"Content-type": "application/json"});
  if (res.statusCode == 200) {
    print("created new user");
    userModel = UserModel.fromMap(jsonDecode(res.body)['output']);
  }
  return userModel;
}
