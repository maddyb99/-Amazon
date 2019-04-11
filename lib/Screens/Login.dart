import 'dart:async' show Future;

import 'package:Not_Amazon/Screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new LoginPage(title: '!Amazon Login');
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<LoginPage> {

  bool _autoValidate = false,
      _login = false,
      _success = true;
  String _email, _password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
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
      return Center(child: CircularProgressIndicator(value: null,));
    else
      return new RaisedButton(
        onPressed: _emailLogin,
        child: Text('SignIn'),
        elevation: 2.0,
        color: Colors.cyanAccent,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))),
      );
  }

  Widget incorrect() {
    if (_success)
      return SizedBox(width: 0.0, height: 0.0,);
    else
      return Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text('Incorrect Details!',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Hme(user: user)));
            },
            splashColor: Theme.of(context).scaffoldBackgroundColor,
            child: new Text('Skip'),
          )
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        bottomOpacity: 0.0,
      ),
      //backgroundColor: Colors.white,

      body: new Center(
        child: SingleChildScrollView(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset('assets/images/logo.jpeg',
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
                          if (value.isEmpty)
                            return 'Enter Email';
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
                            else if (value.length < 8)
                              return 'Too Short';
                          },
                          autovalidate: _autoValidate,
                          onSaved: (input) => _password = input,
                        )
                    ),
                    incorrect(),
                    new Container(
                      height: 50.0,
                      width: _width,
                      padding: EdgeInsets.only(top: 10.0),
                      child: isLogin(),
                    ),
                  ]
                  ),
                ),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: new Text('Sign up?'),
                        padding: EdgeInsets.only(top: 20.0),
                      )
                    ]
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/Home');
                      },
                      child: new Image.asset('assets/images/fb.png',
                        scale: 5.0,

                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new MaterialButton(
                      onPressed: gLogin,
                      child: new Image.asset('assets/images/google.png',
                        scale: 1.0,
                      ),
                    ),
                  ],
                ),

              ]
          ),
        ),
      ),
    );
  }
}