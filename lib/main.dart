import 'package:attendance_app/circle_button.dart';
import 'package:attendance_app/drawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  const AttendanceStateful({super.key});

  @override
  State<StatefulWidget> createState() => AttendanceWidgetState();
}

class AttendanceWidgetState extends State<AttendanceStateful> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("출석 체크"), centerTitle: true,),
      drawer: AttendanceDrawer(),
      body: Column(
        children: [
          Expanded(
              child: CircleButton(
                radius: 100.0,
                borderSize: 10.0,
                borderColor: Colors.blue,
                foregroundColor: Colors.white,
                child: const Center(

                  child: SizedBox(
                    height: 100.0,
                    child: Text("출석체크",),
                  ),
                ),
                onTap: () {

                },
              ),
          ),


          Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListView.builder(itemBuilder: (context, index) {

                    }),
                  ),

                  const Expanded(
                      flex: 2,
                      child: Center(
                        child: Icon(Icons.arrow_right_alt_outlined),
                      )
                  ),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(itemBuilder: (context, index) {

                    }),
                  ),
                ],
              )
          )
        ]
      ),
    );
  }
}




