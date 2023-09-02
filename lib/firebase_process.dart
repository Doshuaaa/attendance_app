import 'package:attendance_app/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

    if(list.isEmpty) {
      DocumentReference documentRef = await userRef.add({
        "name" : "김하나",
        "attendance" : true
      });

      await userRef.add({
        "name" : "김하나",
        "attendance" : true
      });
      await userRef.add({
        "name" : "김영석",
        "attendance" : true
      });
      await userRef.add({
        "name" : "강민수",
        "attendance" : true
      });
      await userRef.add({
        "name" : "이영희",
        "attendance" : true
      });
      await userRef.add({
        "name" : "나희라",
        "attendance" : true
      });
      await userRef.add({
        "name" : "류인석",
        "attendance" : true
      });
      await userRef.add({
        "name" : "하도윤",
        "attendance" : true
      });
    }
    else {

    }


    //DocumentReference documentRef = ;
  }

  void updateStudentAttendance(String num)  {
    DocumentReference docRef = userRef.doc(num);
    docRef.update({"attendance" : true});
  }

  List<QueryDocumentSnapshot> getStudentList() {

    userRef.get().then((QuerySnapshot value) {
      list = value.docs;
      for (var element in list) {
        Student student = Student.fromJson(element.data() as Map<String, dynamic>);
      }
    });
    return list;
  }

  // Future<void> studentDataIsEmpty(String date) {
  //
  //
  //
  // }
}