import 'package:demo_app/models/user.dart';
import 'package:demo_app/services/database.dart';
import 'package:demo_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> courses = ['Flutter','Python', "Java", 'USACO'];

  // form values
  String _currentName;
  String _currentTopic;
  String _currentDate;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;

          return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your instructor information',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),

                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.date,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter a when your course is' : null,
                    onChanged: (val) => setState(() => _currentDate = val),
                  ),
                  SizedBox(height: 20.0),
                  // dropdown

                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    // value: _currentTopic ?? userData.topic,
                    items: courses.map((course){
                      return DropdownMenuItem(
                        value: course,
                        child: Text("$course"),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentTopic = val),
                  ),
                  RaisedButton(
                      color: Colors.blueGrey[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                              _currentTopic ?? userData.topic,
                              _currentDate ?? userData.date,
                              16);
                          Navigator.pop(context);
                        }
                      }
                  ),
                ],
              )
          );
        } else {
            return Loading();
        }

      }
    );
  }
}
