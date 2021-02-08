import 'package:assignment_app/firebaseMethods.dart';
import 'package:assignment_app/screens/otpScreen.dart';
import 'package:assignment_app/widgets/loading.dart';
import 'package:assignment_app/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpWithPhoneNo extends StatefulWidget {
  @override
  _SignUpWithPhoneNoState createState() => _SignUpWithPhoneNoState();
}

class _SignUpWithPhoneNoState extends State<SignUpWithPhoneNo> {
  GlobalKey<FormState> _key = new GlobalKey();
  TextEditingController phController = new TextEditingController();
  FocusNode phNode = FocusNode();
  bool isEnabled = false, loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange.shade100,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Sign Up with Phone Number",
                      style:
                          TextStyle(color: Colors.indigoAccent, fontSize: 25),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      initialValue: "+91",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: "Country Code",
                        labelStyle: TextStyle(color: Colors.indigoAccent),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigoAccent)),
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
                    TextFormField(
                      controller: phController,
                      onChanged: (String val) {
                        val = val.trim();
                        if (val.length > 10 || val.length < 10)
                          setState(() {
                            isEnabled = false;
                          });
                        else
                          setState(() {
                            isEnabled = true;
                          });
                      },
                      validator: (String val) {
                        val = val.trim();
                        if (val.length > 10 || val.length < 10)
                          return "Invalid mobile number";
                        return null;
                      },
                      showCursor: true,
                      keyboardAppearance: Brightness.light,
                      cursorColor: Colors.indigoAccent,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
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
                      focusNode: phNode,
                    ),
                  ],
                ),
              ),
            ),
            loading ? LoadingWidget(msg: 'Sending OTP') : Container()
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: isEnabled
                ? () async {
                    FocusScope.of(context).unfocus();

                    if (_key.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      await sendCodeToPhoneNumber(
                        phonenumber: phController.text,
                        context: context,
                      );
                      await Future.delayed(Duration(seconds: 1), () {});
                      setState(() {
                        loading = false;
                      });
                    }
                  }
                : null,
            child: Container(
              color: isEnabled ? Colors.indigoAccent : Colors.grey,
              height: MediaQuery.of(context).size.height * 0.06,
              width: double.infinity,
              child: Center(
                child: Text(
                  "Send OTP",
                  style: TextStyle(
                      color: Colors.orange.shade100,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
