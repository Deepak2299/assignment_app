import 'package:assignment_app/methods/gets/getUser.dart';
import 'package:assignment_app/methods/puts/updateUser.dart';
import 'package:assignment_app/models/userModel.dart';
import 'package:assignment_app/screens/signUpWithPhoneNo.dart';
import 'package:assignment_app/widgets/loading.dart';
import 'package:assignment_app/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({@required this.phone});
  String phone;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isEnabled = false, loading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  FocusNode nameNode = FocusNode();
  FocusNode fatherNameNode = FocusNode();
  FocusNode addressNode = FocusNode();
  UserModel userModel;
  GlobalKey<FormState> _key = GlobalKey();

  fetchData() async {
    UserModel user = await getUser(phone: widget.phone);
    setState(() {
      userModel = user;
      nameController.text = userModel.name;
      fatherNameController.text = userModel.fathername;
      addressController.text = userModel.address;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("Home"),
        actions: [
          widget.phone != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GestureDetector(
                        child: Text(
                          "Logout  ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        onTap: () async {
                          SharedPreferences _pref =
                              await SharedPreferences.getInstance();

                          await _pref.remove("phone");
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);
                        }),
                  ),
                )
              : Center(
                  child: GestureDetector(
                      child: Text("Login  ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      onTap: () async {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => SignUpWithPhoneNo()));
                      }),
                )
        ],
      ),
      body: widget.phone != null
          ? userModel != null
              ? Stack(
                  children: [
                    Form(
                      key: _key,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Center(
                                  child: Text(
                                    "PROFILE",
                                    style: TextStyle(
                                        color: Colors.indigoAccent,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        wordSpacing: 2),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  controller: nameController,
                                  enabled: isEnabled,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (String val) {
                                    FocusScope.of(context)
                                        .requestFocus(fatherNameNode);
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
                                    labelStyle:
                                        TextStyle(color: Colors.indigoAccent),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.indigoAccent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.indigoAccent)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.indigoAccent)),
                                    errorStyle:
                                        TextStyle(color: Colors.redAccent),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  initialValue: userModel.phone,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    labelStyle:
                                        TextStyle(color: Colors.indigoAccent),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.indigoAccent)),
//
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.indigoAccent)),
//
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.indigoAccent)),
//
                                    errorStyle:
                                        TextStyle(color: Colors.redAccent),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  enabled: isEnabled,
                                  controller: fatherNameController,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (String val) {
                                    FocusScope.of(context)
                                        .requestFocus(addressNode);
                                  },
                                  focusNode: fatherNameNode,
                                  validator: (String val) {
                                    val = val.trim();
                                    if (val.isEmpty)
                                      return "Father name can't empty";
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.indigoAccent,
                                  decoration: InputDecoration(
                                    labelText: 'Father Name',
                                    labelStyle:
                                        TextStyle(color: Colors.indigoAccent),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.indigoAccent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.indigoAccent)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.indigoAccent)),
                                    errorStyle:
                                        TextStyle(color: Colors.redAccent),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  enabled: isEnabled,
                                  controller: addressController,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (String val) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  focusNode: addressNode,
                                  validator: (String val) {
                                    val = val.trim();
                                    if (val.isEmpty)
                                      return "Address can't empty";
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.indigoAccent,
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    labelStyle:
                                        TextStyle(color: Colors.indigoAccent),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.indigoAccent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.indigoAccent)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.indigoAccent)),
                                    errorStyle:
                                        TextStyle(color: Colors.redAccent),
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
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width / 2.7),
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  isEnabled ? "Update" : "Edit",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.indigoAccent,
                                onPressed: isEnabled
                                    ? () async {
                                        FocusScope.of(context).unfocus();
                                        if (_key.currentState.validate()) {
                                          setState(() {
                                            loading = true;
                                          });
                                          UserModel user = await updateUser(
                                              phone: userModel.phone,
                                              name: nameController.text.trim(),
                                              fatherName: fatherNameController
                                                  .text
                                                  .trim(),
                                              address: addressController.text
                                                  .trim());
                                          fetchData();
                                          setState(() {
                                            loading = false;
                                          });
                                          showToast(msg: "Updated");
                                          setState(() {
                                            isEnabled = false;
                                          });
                                        }
                                      }
                                    : () {
                                        setState(() {
                                          isEnabled = true;
                                        });
                                      }),
                          ),
                        ],
                      ),
                    ),
                    loading
                        ? LoadingWidget(
                            msg: "Updating",
                          )
                        : Container()
                  ],
                )
              : LoadingWidget(msg: "Fetching")
          : Center(
              child: Text(
                "User are not sign up",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.indigoAccent),
              ),
            ),
    ));
  }
}
