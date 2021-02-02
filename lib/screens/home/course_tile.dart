import 'package:flutter/material.dart';
import 'package:demo_app/models/course.dart';

class CourseTile extends StatelessWidget {

  final Course course;
  CourseTile({this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blueAccent,
            child: Text("CM")
          ),
          title: Text(course.name),
          subtitle: Text(
          'Currently teaching ${course.topic} on ${course.date}',
              style: new TextStyle(
                fontSize: 13.5,
              )),
        ),
      )
    );
  }
}
