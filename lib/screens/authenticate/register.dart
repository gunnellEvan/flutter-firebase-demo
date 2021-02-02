import 'package:demo_app/services/auth.dart';
import 'package:demo_app/shared/constants.dart';
import 'package:demo_app/shared/loading.dart';
import 'package:flutter/material.dart';
    
    class Register extends StatefulWidget {

      final Function toggleView;
      Register({this.toggleView});


      @override
      _RegisterState createState() => _RegisterState();
    }
    
    class _RegisterState extends State<Register> {

      final AuthService _auth = AuthService();
      final _formKey = GlobalKey<FormState>();
      bool loading = false;

      // text field state
      String email = '';
      String password = '';
      String error = '';

      @override
      Widget build(BuildContext context) {
        return loading ? Loading() : Scaffold(
          backgroundColor: Colors.blueGrey[100],
          appBar: AppBar(
              backgroundColor: Colors.blue[600],
              elevation: 0.0,
              title: Text(
                  'Become a Coding Minds Instructor!',
                  style: new TextStyle(
                    fontSize: 17.5,
                  )),
            actions: <Widget>[
              FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () {
                    widget.toggleView();
                  }
              )
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  // Image.asset('assets/icon.png'),
                  // SizedBox(height: 20.0),
                  TextFormField(
                    decoration : textInputDecoration.copyWith(hintText: "Email"),
                    validator: (val) => val.isEmpty ? 'Please enter a valid email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration : textInputDecoration.copyWith(hintText: "Password"),
                      validator: (val) => val.length < 6 ? 'Please enter a password that is at least 6 characters long' : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      }
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.blueGrey[400],
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          if (result == null){
                            setState(() {
                              error = 'Invalid Email';
                              loading = false;
                            } );
                          }
                        }
                      }
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red[400], fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    