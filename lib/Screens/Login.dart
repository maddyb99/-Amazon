import 'package:Not_Amazon/Screens/Home.dart';
import 'package:Not_Amazon/Screens/SignIn.dart';
import 'package:flutter/material.dart';

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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                  MaterialPageRoute(builder: (context) => Hme()));
            },
            splashColor: Theme.of(context).scaffoldBackgroundColor,
            child: new Text('Skip'),
          )
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        bottomOpacity: 0.0,
      ),
      body: Center(
        child: SingleChildScrollView(
            child: SignIn()
        ),
      ),
    );
  }
}