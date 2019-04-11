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

  bool _autoValidate=false;
  void _validateInputs(){
    setState(() {
      _autoValidate = true;
    });
  }

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
              Navigator.of(context).pushReplacementNamed('/Home');
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
              new Column(children: <Widget>[
                new Container(
                    width: 300.0,
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: new TextFormField(
                      decoration: new InputDecoration(
                          labelText: "Email or mobile",
                          //disabledBorder: InputBorder.none,
                          //enabledBorder: InputBorder.none,
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
                      ),
                      ),
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value){
                        if(value.isEmpty)
                          return 'Enter Email';
                      },
                      autovalidate: _autoValidate,
                    )
                ),
                new Container(
                    width: 300.0,
                    child: new TextFormField(
                      obscureText: true,
                      decoration: new InputDecoration(
                          labelText: 'Password',
                          //disabledBorder: InputBorder.none,
                          //enabledBorder: InputBorder.none,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
                        ),
                      ),
                      validator: (String value){
                        if(value.isEmpty)
                          return 'Enter Password';
                      },
                     autovalidate: _autoValidate,
                    )
                ),
                new Container(
                    child: new RaisedButton(
                        onPressed:(){
                          _validateInputs();
                          Navigator.of(context).pushReplacementNamed('/Home');
                          },
                        child: new Text('Sign in'),
                      elevation: 2.0,
                      color: Colors.cyanAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))),
                    ),
                ),
              ]
              ),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: new Text('Sign up?'),
                      padding: EdgeInsets.only(top:20.0),
                    )
                  ]
              ),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   /* new RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/Home');
                        },
                      padding: EdgeInsets.all(0.0),
                        child: new Container(
                          width: 200.0,
                          padding: EdgeInsets.all(0.0),
                          height: 30.0,
                          decoration: new BoxDecoration(
                            image: DecorationImage(
                              image: new AssetImage('assets/images/fb.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                    ),*/
                    new MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/Home2');
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
                    onPressed: () {
                      SnackBar(
                        content: Text('dfgvd'),
                      );
                      _displaySnackBar(context);
                    },
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
_displaySnackBar(BuildContext context) {
  final snackBar = SnackBar(content: Text('Are you talkin\' to me?'));
  return Builder(builder: (BuildContext context){
    Scaffold.of(context).showSnackBar(snackBar);
  });
   // edited line
}