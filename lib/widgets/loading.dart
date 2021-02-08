import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  String msg;
  LoadingWidget({@required this.msg});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              msg ?? 'Loading',
              style: TextStyle(
                  color: Colors.orange.shade100, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 20),
            CircularProgressIndicator(
              backgroundColor: Colors.orange.shade100,
            ),
          ],
        ),
      ),
    );
  }
}
