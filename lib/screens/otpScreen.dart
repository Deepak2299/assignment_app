import 'package:assignment_app/firebaseMethods.dart';
import 'package:assignment_app/methods/gets/getUser.dart';
import 'package:assignment_app/models/userModel.dart';
import 'package:assignment_app/screens/homeScreen.dart';
import 'package:assignment_app/screens/signUpScreen.dart';
import 'package:assignment_app/widgets/loading.dart';
import 'package:assignment_app/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends StatefulWidget {
  String verificationId, phoneNumber, code;
  bool stored;
  OTPScreen({
    @required this.verificationId,
    this.phoneNumber,
    this.code,
  });

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController otpController = TextEditingController();
  bool loading = false, isEnable = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange.shade100,
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _key,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Verify your phone number here",
                      style: TextStyle(
                          color: Colors.indigoAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          wordSpacing: 1.5),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Paste OTP here",
                      style: TextStyle(
                          color: Color(0xff888888),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          wordSpacing: 1.5),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      autofocus: true,
                      controller: otpController,
                      validator: (String code) {
                        if (code.isEmpty) return "Enter OTP Code";
                        return null;
                      },
                      onChanged: (str) {
                        str = str.trim();
                        if (str.length > 0)
                          isEnable = true;
                        else
                          isEnable = false;
                        setState(() {});
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        labelText: "OTP Code",
                        labelStyle: TextStyle(color: Colors.indigoAccent),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigoAccent)),
                        focusColor: Colors.indigoAccent,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigoAccent)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigoAccent)),
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
            loading ? LoadingWidget(msg: 'Verifying') : Container()
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
              onTap: isEnable
                  ? () async {
                      if (_key.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        bool verified = await authFunction(
                            verificationId: widget.verificationId,
                            phoneNumber: widget.code + widget.phoneNumber,
                            sms: otpController.text);
                        setState(() {
                          loading = false;
                        });
                        if (verified) {
                          UserModel userModel =
                              await getUser(phone: widget.phoneNumber);
                          if (userModel != null) {
                            SharedPreferences _pref =
                                await SharedPreferences.getInstance();
                            await _pref.setString("phone", widget.phoneNumber);
                            Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => HomeScreen(
                                          phone: widget.phoneNumber,
                                        )),
                                (routes) => false);
                          } else {
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => SignUpScreen(
                                          phone: widget.phoneNumber,
                                        )));
                          }
                        }
                      }
                    }
                  : null,
              child: Container(
                color: isEnable ? Colors.indigoAccent : Colors.grey,
                height: MediaQuery.of(context).size.height * 0.06,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Verify",
                    style: TextStyle(
                      color: Colors.orange.shade100,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
