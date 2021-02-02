import 'package:demo_app/models/course.dart';
import 'package:demo_app/screens/home/settings_form.dart';
import 'package:demo_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/services/database.dart';
import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/screens/home/course_list.dart';



class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Course>>.value(
      value: DatabaseService().courses,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          title: Text('Coding Minds \n   Instructors'),
          backgroundColor: Colors.blue[600],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon:  Icon(Icons.logout),
              label: Text('Sign Out'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.account_circle),
              label: Text('User Info'),
              onPressed: () => _showSettingsPanel()
            )
          ],
        ),
        body: CourseList(),
      ),
    );
  }
}
