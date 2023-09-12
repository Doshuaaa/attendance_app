import 'package:attendance_app/drawer.dart';
import 'package:attendance_app/firebase_process.dart';
import 'package:attendance_app/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

late String currentSetDay;

class AttendanceCheckScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => AttendanceCheckState();
}

class AttendanceCheckState extends State<AttendanceCheckScreen> {




  @override
  void initState() {

    super.initState();
    currentSetDay = getToday();
    //process.addStudentData();
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
                  setState(()  {
                    currentSetDay = setPreviousDay(currentSetDay);
                    //process.addStudentData();
                  });
                }, icon: const Icon(Icons.chevron_left)),
                TextButton(onPressed: () {datePicker(currentSetDay);}, child: Text(currentSetDay),),
                IconButton(onPressed: () {
                  setState(()  {
                    currentSetDay = setNextDay(currentSetDay);
                    //process.addStudentData();
                  });
                }, icon: const Icon(Icons.chevron_right))
              ],
            ),
            Expanded(
                child: AttendanceStateScreen()
            )
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

class AttendanceStateScreen extends StatefulWidget {


  const AttendanceStateScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return FirebaseProcess();
  }

}

class FirebaseProcess extends State<AttendanceStateScreen>{

  final fireStore = FirebaseFirestore.instance;
  late CollectionReference userRef;
  late List<QueryDocumentSnapshot> list;

  // String name, Map<String, dynamic> map
  Future<void> addStudentData() async {
    await userRef.get().then((value) {
      list = value.docs;
    });

    if (list.isEmpty) {
      await userRef.doc("1").set({
        "name": "김하나",
        "attendance": "true"
      });

      await userRef.doc("2").set({
        "name": "김하나",
        "attendance": "true"
      });
      await userRef.doc("3").set({
        "name": "김영석",
        "attendance": "true"
      });
      await userRef.doc("4").set({
        "name": "강민수",
        "attendance": "true"
      });
      await userRef.doc("5").set({
        "name": "이영희",
        "attendance": "true"
      });
      await userRef.doc("6").set({
        "name": "나희라",
        "attendance": "false"
      });
      await userRef.doc("7").set({
        "name": "류인석",
        "attendance": "true"
      });
      await userRef.doc("8").set({
        "name": "하도윤",
        "attendance": "true"
      });
    }

    //DocumentReference documentRef = ;
  }

  void updateStudentAttendance(String num) {
    DocumentReference docRef = userRef.doc(num);
    docRef.update({"attendance": "true"});
  }


  Future<List<QueryDocumentSnapshot<Object?>>> getStudentData() async {
    await addStudentData();
    late List<QueryDocumentSnapshot> studentList;
    await userRef.get().then((value) {
      studentList = value.docs;
    });
    return studentList;
  }

  Future<void> setAttendance(bool flag, String index) async {

    if(flag) {
      userRef.doc(index).update({'attendance' : "false"});
    } else {
      userRef.doc(index).update({'attendance' : "true"});
    }

  }

  @override
  Widget build(BuildContext context) {
    userRef = fireStore.collection("students").doc("class1").collection(currentSetDay);

    return FutureBuilder(
      future: getStudentData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot<Object?>>? getList = snapshot.data;

          List<QueryDocumentSnapshot<Object?>> attendedList = List.empty(growable: true);
          List<QueryDocumentSnapshot<Object?>> absentedList = List.empty(growable: true);

          for (QueryDocumentSnapshot inform in getList!) {
            if (inform.get("attendance") == "true") {
              attendedList.add(inform);
            }
            else {
              absentedList.add(inform);
            }
          }

          return Column(
            children: [
              const Text("출석자 명단"),
              Expanded(
                  child: ListView.builder(
                      itemCount: attendedList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${attendedList.elementAt(index).id}번 ${attendedList.elementAt(index).get("name")}"),
                            ElevatedButton(onPressed: () {
                              setState(() {
                                setAttendance(true, attendedList.elementAt(index).id);
                              });

                            },
                                child: Text("결석으로 변경", style: TextStyle(color: Colors.red),))
                          ],
                        );
                      }
                  )
              ),
              const Text("결석자 명단"),
              Expanded(
                // width: double.infinity,
                // height: 300,
                  child: ListView.builder(
                    itemCount: absentedList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${absentedList.elementAt(index).id}번 ${absentedList.elementAt(index).get("name")}"),
                          ElevatedButton(onPressed: () {
                            setState(() {
                              setAttendance(false, absentedList.elementAt(index).id);
                            });

                          },
                              child: const Text("출석으로 변경"))
                        ],
                      );
                    },
                  )
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
