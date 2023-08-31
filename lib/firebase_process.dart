import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProcess {

  final fireStore = FirebaseFirestore.instance;
  late CollectionReference userRef;

  FirebaseProcess() {
    userRef = fireStore.collection("class1");
  }

  // String name, Map<String, dynamic> map
  Future<void> addStudentData() async {

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

    //DocumentReference documentRef = ;
  }

  void updateStudentAttendance(String num)  {
    DocumentReference docRef = userRef.doc(num);
    docRef.update({"attendance" : true});
  }
}