import 'package:assignment_app/models/userModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<UserModel> getUser({@required String phone}) async {
  UserModel userModel;
  var res = await http.get(
      "https://temprestserver.herokuapp.com/tasks/" + phone,
      headers: {"Content-type": "application/json"});
  if (res.statusCode == 200) {
    userModel = UserModel.fromMap(jsonDecode(res.body)['output']);
  }
  return userModel;
}
