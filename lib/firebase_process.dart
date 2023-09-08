import 'package:attendance_app/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseProcess {

  final fireStore = FirebaseFirestore.instance;
  late CollectionReference userRef;
  late List<QueryDocumentSnapshot> list;
  String date;

  FirebaseProcess(this.date) {
    userRef = fireStore.collection("students").doc("class1").collection(date);
  }

  // String name, Map<String, dynamic> map
  Future<void> addStudentData() async {
    await userRef.get().then((value) {
      list = value.docs;
    });

    if (list.isEmpty) {
      DocumentReference documentRef = await userRef.add({
        "name": "김하나",
        "attendance": "true"
      });

      await userRef.add({
        "name": "김하나",
        "attendance": "true"
      });
      await userRef.add({
        "name": "김영석",
        "attendance": "true"
      });
      await userRef.add({
        "name": "강민수",
        "attendance": "true"
      });
      await userRef.add({
        "name": "이영희",
        "attendance": "true"
      });
      await userRef.add({
        "name": "나희라",
        "attendance": "true"
      });
      await userRef.add({
        "name": "류인석",
        "attendance": "true"
      });
      await userRef.add({
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


  FutureBuilder getStudentList() {
    return FutureBuilder(
      future: getStudentData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot<Object?>> getList = snapshot.data;

          List<QueryDocumentSnapshot<Object?>> attendedList = List.empty(growable: true);
          List<QueryDocumentSnapshot<Object?>> absentedList = List.empty(growable: true);

          for (QueryDocumentSnapshot inform in getList) {
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
        //   // width: double.infinity,
        //   //   height: 300,
                    child: ListView.builder(
                      itemCount: attendedList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${index + 1}번 ${attendedList.elementAt(index).get("name")}"),
                            ElevatedButton(onPressed: () {}, child: Text("결석으로 변경", style: TextStyle(color: Colors.red),))
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
                      Text("${index + 1}번 ${absentedList.elementAt(index).get("name")}"),
                      ElevatedButton(onPressed: () {}, child: const Text("출석으로 변경"))
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

  Future<List<QueryDocumentSnapshot<Object?>>> getStudentData() async {
    late List<QueryDocumentSnapshot> studentList;
    await userRef.get().then((value) {
      studentList = value.docs;
    });
    return studentList;
  }
}