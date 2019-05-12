import 'dart:async' show Future;

import 'package:Not_Amazon/Global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({this.fn});

  final VoidCallback fn;

  @override
  SignUpState createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  bool _autoValidate = false, _success = true, _signup = false;
  String _email, _password, _checkpass, _name;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseUser user;
  Future<void> signUp() async {
    FormState formState = _formKey.currentState;
    setState(() {
      _autoValidate = true;
    });
    if (formState.validate()) {
      formState.save();
      try {
        setState(() {
          _signup = true;
          _success = true;
        });
        user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        userreference = Firestore.instance.collection("users");
        userreference.document().setData({'email': _email, 'name': _name});
        usersnapshot = await userreference
            .where('email', isEqualTo: _email)
            .getDocuments();
        Navigator.of(context).pushReplacementNamed('/Home');
        setState(() {
          _signup = false;
          _autoValidate = false;
        });
        formState.reset();
      } catch (e) {
        print(e.message);
        setState(() {
          _signup = false;
          _success = false;
          _autoValidate = false;
        });
      }
    }
  }

  Widget isLogin() {
    if (_signup)
      return Center(
          child: CircularProgressIndicator(
            value: null,
          ));
    else
      return new RaisedButton(
        onPressed: signUp,
        child: Text('SignIn'),
        elevation: 2.0,
        color: Colors.cyanAccent,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))),
      );
  }

  Widget incorrect() {
    if (_success)
      return SizedBox(
        width: 0.0,
        height: 0.0,
      );
    else
      return Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text(
          'Incorrect Details!',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        super.setState(widget.fn);
                        //Navigator.of(context).pushReplacementNamed('/Login');
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    new Container(
                      width: 300.0,
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Name",
                          //disabledBorder: InputBorder.none,
                          //enabledBorder: InputBorder.none,
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String value) {
                          if (value.isEmpty) return 'Enter Name';
                        },
                        autovalidate: _autoValidate,
                        onSaved: (input) => _name = input,
                      ),
                    ),
                    new Container(
                      width: 300.0,
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Email or mobile",
                          //disabledBorder: InputBorder.none,
                          //enabledBorder: InputBorder.none,
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String value) {
                          if (value.isEmpty) return 'Enter Email';
                        },
                        autovalidate: _autoValidate,
                        onSaved: (input) => _email = input,
                      ),
                    ),
                    new Container(
                      width: 300.0,
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Password",
                          //disabledBorder: InputBorder.none,
                          //enabledBorder: InputBorder.none,
                        ),
                        autofocus: false,
                        validator: (String value) {
                          if (value.isEmpty)
                            return 'Enter Password';
                          else if (value.length < 8)
                            return 'Too short';
                          else if (_password != _checkpass)
                            return 'Passwords dont match';
                        },
                        autovalidate: _autoValidate,
                        obscureText: true,
                        onSaved: (input) => _password = input,
                      ),
                    ),
                    new Container(
                      width: 300.0,
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Re- enter Password",
                          //disabledBorder: InputBorder.none,
                          //enabledBorder: InputBorder.none,
                        ),
                        autofocus: false,
                        validator: (String value) {
                          if (value.isEmpty)
                            return 'Enter Password';
                          else if (value.length < 8)
                            return 'Too short';
                          else if (_password != _checkpass)
                            return 'Passwords dont match';
                        },
                        autovalidate: _autoValidate,
                        obscureText: true,
                        onSaved: (input) => _checkpass = input,
                      ),
                    ),
                    incorrect(),
                    new Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: isLogin(),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
