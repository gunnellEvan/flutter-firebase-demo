import 'package:demo_app/models/course.dart';
import 'package:demo_app/screens/home/course_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class CourseList extends StatefulWidget {
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {

    final courses = Provider.of<List<Course>>(context) ?? [];

    // courses.forEach((course) {
    //   print(course.topic);
    //   print(course.date);
    //   print(course.numLessons);
    // });
 
    // for (var doc in courses.documents){
    //   print(doc.data);
    // }
    //print(courses.documents);
    return ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return CourseTile(course: courses[index]);
        },
    );
  }
}
