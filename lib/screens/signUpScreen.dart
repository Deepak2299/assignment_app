import 'package:assignment_app/methods/puts/addNewUser.dart';
import 'package:assignment_app/models/userModel.dart';
import 'package:assignment_app/screens/homeScreen.dart';
import 'package:assignment_app/widgets/loading.dart';
import 'package:assignment_app/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({@required this.phone});
  String phone;
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  FocusNode nameNode = FocusNode();
  FocusNode fatherNameNode = FocusNode();
  FocusNode addressNode = FocusNode();
  GlobalKey<FormState> _key = GlobalKey();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange.shade100,
        body: Stack(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _key,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Text(
                          "Personal Details",
                          style: TextStyle(
                              color: Colors.indigoAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              wordSpacing: 1.8),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String val) {
                          FocusScope.of(context).requestFocus(fatherNameNode);
                        },
                        focusNode: nameNode,
                        validator: (String val) {
                          val = val.trim();
                          if (val.isEmpty) return "Name can't empty";
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.indigoAccent,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.indigoAccent),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.indigoAccent)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.indigoAccent)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.indigoAccent)),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: fatherNameController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String val) {
                          FocusScope.of(context).requestFocus(addressNode);
                        },
                        focusNode: fatherNameNode,
                        validator: (String val) {
                          val = val.trim();
                          if (val.isEmpty) return "Father name can't empty";
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.indigoAccent,
                        decoration: InputDecoration(
                          labelText: 'Father Name',
                          labelStyle: TextStyle(color: Colors.indigoAccent),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.indigoAccent)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.indigoAccent)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.indigoAccent)),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: addressController,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (String val) {
                          FocusScope.of(context).unfocus();
                        },
                        focusNode: addressNode,
                        validator: (String val) {
                          val = val.trim();
                          if (val.isEmpty) return "Address can't empty";
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.indigoAccent,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle(color: Colors.indigoAccent),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.indigoAccent)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.indigoAccent)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.indigoAccent)),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            loading
                ? LoadingWidget(
                    msg: "Signing Up",
                  )
                : Container()
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
              if (_key.currentState.validate()) {
                setState(() {
                  loading = true;
                });
                UserModel userModel = await addNewUser(
                    name: nameController.text.trim(),
                    phone: widget.phone,
                    fatherName: fatherNameController.text.trim(),
                    address: addressController.text.trim());
                await Future.delayed(Duration(seconds: 1), () {});
                setState(() {
                  loading = false;
                });
                showToast(msg: "Loging Successful");
                if (userModel != null) {
                  SharedPreferences _pref =
                      await SharedPreferences.getInstance();
                  await _pref.setString("phone", widget.phone);
                  Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => HomeScreen(
                          phone: widget.phone,
                        ),
                      ),
                      (route) => false);
                } else
                  showToast(msg: "Already exists");
              }
            },
            child: Container(
              color: Colors.indigoAccent,
              height: MediaQuery.of(context).size.height * 0.06,
              width: double.infinity,
              child: Center(
                child: Text(
                  "Signup",
                  style: TextStyle(
                    color: Colors.orange.shade100,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
