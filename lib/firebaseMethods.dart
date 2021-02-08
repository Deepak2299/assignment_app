import 'package:assignment_app/screens/otpScreen.dart';
import 'package:assignment_app/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

Future<bool> authFunction(
    {String verificationId,
    String phoneNumber,
    String code,
    String sms}) async {
  AuthCredential _credentials;

  _credentials = PhoneAuthProvider.getCredential(
      verificationId: verificationId, smsCode: sms);
  try {
    AuthResult result = await _firebaseAuth.signInWithCredential(_credentials);
    if (result.user != null) {
      showToast(msg: "Congrats, your phone number is verified");
      return true;
    } else
      showToast(msg: "Phone number is not verified");
    return false;
  } on PlatformException catch (e) {
    showToast(msg: e.message);

    return false;
  }
}

sendCodeToPhoneNumber(
    {@required String phonenumber, @required BuildContext context}) {
  _firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+91" + phonenumber,
      timeout: Duration(seconds: 5),
      verificationFailed: (AuthException authException) {
        showToast(msg: authException.message);
      },
      codeSent: (String verificationId, [int forceResendingToken]) async {
        await Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => OTPScreen(
                    verificationId: verificationId,
                    phoneNumber: phonenumber,
                    code: "+91",
                  )),
        ); //
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
        print(verificationId);
        print("Timeout");
      });
}
