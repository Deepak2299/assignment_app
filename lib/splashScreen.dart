import 'package:assignment_app/screens/homeScreen.dart';
import 'package:assignment_app/screens/signUpWithPhoneNo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Checking for user is login or not
    Future.delayed(Duration(seconds: 2), () async {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      String phno = await _pref.getString("phone");

      phno != null
          ? Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (context) => HomeScreen(
                        phone: phno,
                      )))
          : Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) => SignUpWithPhoneNo()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange.shade100,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Karman",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                    color: Colors.indigoAccent),
              ),
              SizedBox(height: 20),
              Text(
                "Analytics",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                    color: Colors.indigoAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
