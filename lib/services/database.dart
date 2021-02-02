import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/models/course.dart';
import 'package:demo_app/models/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({ this.uid });


  // collection reference
  final CollectionReference coursesCollection = Firestore.instance.collection("courses");

  Future updateUserData(String name, String topic, String date, int numLessons) async {
    return await coursesCollection.document(uid).setData({
      'name' : name,
      'topic' : topic,
      'date' : date,
      'numLessons' : numLessons,
    });
  }

  // course list from snapshot
  List<Course> _courseListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Course(
        name: doc.data['name'] ?? '',
        topic: doc.data['topic'] ?? '',
        date: doc.data['date'] ?? '',
        numLessons: doc.data['numLessons'] ?? 0
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      topic: snapshot.data['topic'],
      date: snapshot.data['date']
    );
  }

  // get courses stream
  Stream<List<Course>> get courses {
    return coursesCollection.snapshots()
    .map(_courseListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return coursesCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}