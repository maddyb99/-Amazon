import 'dart:async' show Future;

import 'package:Not_Amazon/Screens/Home.dart';
import 'package:Not_Amazon/Screens/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SignInPage();
  }
}

class SignInPage extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  bool _autoValidate = false,
      _login = false,
      _reset = false,
      _success = true,
      _forgot = false;
  int _signUp = 0;
  String _email, _password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseUser user;
  FirebaseAuth _auth = FirebaseAuth.instance;
  double _width = 88.0;

  void initStat() {
    user = null;
  }

  Future<void> _emailLogin() async {
    setState(() async {
      final formState = _formKey.currentState;
      setState(() {
        _autoValidate = true;
      });
      if (formState.validate()) {
        formState.save();
        try {
          setState(() {
            _login = true;
            _width = 50.0;
            _success = true;
          });
          user = await _auth.signInWithEmailAndPassword(
              email: _email, password: _password);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Hme(user: user)));
          setState(() {
            _login = false;
            _width = 88.0;
            _autoValidate = false;
          });
          formState.reset();
        } catch (e) {
          print(e.message);
          setState(() {
            _login = false;
            _width = 88.0;
            _success = false;
            _autoValidate = false;
          });
        }
      }
    });
  }

  Future<void> _emailReset() async {
    FormState formState = _formKey.currentState;
    setState(() {
      _autoValidate = true;
    });
    try {
      if (formState.validate()) {
        setState(() {
          _reset = true;
          _width = 50.0;
          _success = true;
        });
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        setState(() {
          _reset = false;
          _width = 88.0;
          _autoValidate = false;
        });
        //formState.reset();
      }
    } catch (e) {
      print(e.message);
      setState(() {
        _reset = false;
        _width = 88.0;
        _success = false;
        _autoValidate = false;
      });
    }
  }

  Future<void> gLogin() async {
    try {
      GoogleSignInAccount account = await GoogleSignIn().signIn();
      GoogleSignInAuthentication auth = await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      user = await _auth.signInWithCredential(credential);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Hme(user: user)));
      setState(() {
        _login = false;
        _width = 88.0;
        _autoValidate = false;
      });
    } catch (e) {
      print(e.message);
      setState(() {
        _login = false;
        _width = 88.0;
        _success = false;
        _autoValidate = false;
      });
    }
  }

  Widget isLogin() {
    if (_login)
      return Container(
          height: 50.0,
          width: 50.0,
          child: Center(
              child: CircularProgressIndicator(
            value: null,
          )));
    else
      return new RaisedButton(
        onPressed: _emailLogin,
        child: Text('SignIn'),
        elevation: 2.0,
        color: Colors.cyanAccent,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))),
      );
  }

  Widget isReset() {
    if (_reset)
      return Container(
          height: 50.0,
          width: 50.0,
          child: Center(
              child: CircularProgressIndicator(
            value: null,
          )));
    else
      return new RaisedButton(
        onPressed: _emailReset,
        child: Text('Reset'),
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

  Widget forgot() {
    if (_success)
      return new FlatButton(
          onPressed: () {
            setState(() {
              _signUp = 1;
            });
          },
          child: Text('SignUp?'));
    else
      return new FlatButton(
          onPressed: () {
            setState(() {
              _forgot = !_forgot;
              _success = true;
            });
          },
          child: Text('Forgot Password?'));
  }

  Widget createBody() {
    if (_signUp == 1)
      return Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                  contentPadding: EdgeInsets.only(left: 100.0),
                  leading: Icon(Icons.arrow_back),
                  title: Text('Back to SignIn'),
                  onTap: () {
                    setState(() {
                      _signUp = 0;
                    });
                  }),
              new MaterialButton(
                onPressed: () {
                  setState(() {
                    _signUp = 2;
                  });
                },
                child: Text('Continue with Email'),
                color: Theme.of(context).accentColor,
              ),
              new MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/Home');
                },
                child: new Image.asset(
                  'assets/images/fb.png',
                  scale: 5.0,
                ),
              ),
              new MaterialButton(
                onPressed: gLogin,
                child: new Image.asset(
                  'assets/images/google.png',
                  scale: 1.0,
                ),
              ),
            ],
          ),
        ),
      );
    else if (_signUp == 2)
      return SignUp();
    else if (_forgot)
      return new Center(
        child: SingleChildScrollView(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  'assets/images/logo.jpeg',
                  fit: BoxFit.contain,
                  scale: 15,
                ),
                Form(
                  key: _formKey,
                  child: new Column(children: <Widget>[
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
                    incorrect(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              _forgot = !_forgot;
                            });
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 28.0, top: 8.0, left: 8.0),
                          child: isReset(),
                        ),
                      ],
                    ),
                  ]),
                ),
              ]),
        ),
      );
    else
      return new Center(
        child: SingleChildScrollView(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  'assets/images/logo.jpeg',
                  fit: BoxFit.contain,
                  scale: 15,
                ),
                Form(
                  key: _formKey,
                  child: new Column(children: <Widget>[
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
                        child: new TextFormField(
                          obscureText: true,
                          decoration: new InputDecoration(
                            labelText: 'Password',
                            //disabledBorder: InputBorder.none,
                            //enabledBorder: InputBorder.none,
                            /*border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
                          ),*/
                          ),
                          validator: (String value) {
                            if (value.isEmpty)
                              return 'Enter Password';
                            else if (value.length < 8) return 'Too Short';
                          },
                          autovalidate: _autoValidate,
                          onSaved: (input) => _password = input,
                        )),
                    incorrect(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: forgot(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 28.0, top: 8.0),
                          child: isLogin(),
                        ),
                      ],
                    ),
                  ]),
                ),
              ]),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return createBody();
  }
}
