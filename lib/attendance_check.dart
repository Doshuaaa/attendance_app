import 'package:attendance_app/drawer.dart';
import 'package:attendance_app/firebase_process.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceCheckScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => AttendanceCheckState();

}

class AttendanceCheckState extends State<AttendanceCheckScreen> {

  late String currentSetDay;

  @override
  void initState() {
    FirebaseProcess process = FirebaseProcess();
    //process.addStudentData();
    super.initState();
    currentSetDay = getToday();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("출석 체크"),),
      drawer: AttendanceDrawer(),
      body: Column(
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {
                  setState(() {
                    currentSetDay = setPreviousDay(currentSetDay);
                  });
                }, icon: const Icon(Icons.chevron_left)),
                TextButton(onPressed: () {datePicker(currentSetDay);}, child: Text(currentSetDay),),
                IconButton(onPressed: () {
                  setState(() {
                    currentSetDay = setNextDay(currentSetDay);
                  });
                }, icon: const Icon(Icons.chevron_right))
              ],
            ),
            Text("출석자 명단"),
            Expanded(
              // width: double.infinity,
              //   height: 300,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${index}번 김하루"),
                        ElevatedButton(
                          onPressed: () {

                          },
                          child: const Text("결석으로 변경"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        )
                      ],
                    );
                  },
                )
            ),
            Text("결석자 명단"),
            Expanded(
                // width: double.infinity,
                // height: 300,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${index}번 김하루"),
                        ElevatedButton(onPressed: () {}, child: const Text("출석으로 변경"))
                      ],
                    );
                  },
                )
            ),
          ],
        ),
    );
  }

  String setNextDay(String day) {
    DateTime time = DateTime.parse(day).add(Duration(days: 1));
    DateFormat format = DateFormat('yyyy-MM-dd');
    String nextDay = format.format(time);
    return nextDay;
  }

  String setPreviousDay(String day) {
    DateTime time = DateTime.parse(day).subtract(Duration(days: 1));
    DateFormat format = DateFormat('yyyy-MM-dd');
    String previousDay = format.format(time);
    return previousDay;
  }

  String getToday() {
    DateTime now = DateTime.now();
    DateFormat format = DateFormat('yyyy-MM-dd');
    String today = format.format(now);
    return today;
  }

  Future datePicker(String day) async {

    DateTime time = DateTime.parse(day);
    DateFormat format = DateFormat('yyyy-MM-dd');


    DateTime? picked = await showDatePicker(

        context: context,
        initialDate: time,
        firstDate: DateTime(2016),
        lastDate: DateTime(2030),

    );

    if(picked != null) {
      setState(() {
      currentSetDay = format.format(picked);
      });
    }
  }
}