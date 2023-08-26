import 'package:attendance_app/drawer.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "출석 체크",
      home: AttendanceStateful());
  }
}

class AttendanceStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AttendanceWidgetState();
}

class AttendanceWidgetState extends State<AttendanceStateful> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("출석 체크"), centerTitle: true,),
      drawer: AttendanceDrawer(),
      body: Container(

      ),
    );
  }
}




