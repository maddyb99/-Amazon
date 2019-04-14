import 'package:Not_Amazon/Screens/Categories.dart';
import 'package:Not_Amazon/Screens/Home.dart';
import 'package:Not_Amazon/Screens/ItemList.dart';
import 'package:Not_Amazon/Screens/Login.dart';
import 'package:Not_Amazon/Screens/SignUp.dart';
import 'package:Not_Amazon/Screens/Splash.dart';
import 'package:flutter/material.dart';

Brightness b = Brightness.light;

void main() async => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '!Amazon',
      routes: <String, WidgetBuilder> {
        '/Splash':(BuildContext context) => new Splash(),
        '/Login':(BuildContext context) => new Login(),
        '/Home':(BuildContext context) => new Hme(),
        '/Items':(BuildContext context) => new Items(cat: "demo"),
        '/Cat': (BuildContext context) => new Category(),
        '/SignUp': (BuildContext context) => new SignUp(),
      },
      darkTheme: new ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        buttonColor: Colors.cyanAccent,
        //scaffoldBackgroundColor: Colors.cyanAccent,
      ),
      theme: new ThemeData(
        brightness: b,
        primarySwatch: Colors.cyan,
        buttonColor: Colors.cyanAccent,
        //scaffoldBackgroundColor: Colors.cyanAccent,
      ),
      home: new Splash(),
    );
  }
}

