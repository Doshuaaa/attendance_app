import 'package:attendance_app/attendance_check.dart';
import 'package:flutter/material.dart';

class AttendanceDrawer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        children: <Widget> [
          UserAccountsDrawerHeader(
            accountName: Text("엄마"),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('asset/person.png'),
            ),
            decoration: BoxDecoration(
                color: Colors.orange
            ),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text("출석 체크"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceCheckScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text("출석 현황"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}