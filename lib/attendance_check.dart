import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AttendanceCheckScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => AttendanceCheckState();

}

class AttendanceCheckState extends State<AttendanceCheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.chevron_left))
            ],
          )
        ],
      ),
    );
  }

}