import 'package:Not_Amazon/Screens/Cart.dart';
import 'package:Not_Amazon/Screens/Categories.dart';
import 'package:Not_Amazon/Screens/CategoryList.dart';
import 'package:Not_Amazon/Screens/Home.dart';
import 'package:Not_Amazon/Screens/ItemList.dart';
import 'package:Not_Amazon/Screens/Login.dart';
import 'package:Not_Amazon/Screens/ProductPage.dart';
import 'package:Not_Amazon/Screens/SignUp.dart';
import 'package:Not_Amazon/Screens/Splash.dart';
import 'package:flutter/material.dart';

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
        '/Items': (BuildContext context) => new ItemPage(),
        '/Cat': (BuildContext context) => new Category(),
        '/CatList': (BuildContext context) => new CategoryList(),
        '/SignUp': (BuildContext context) => new SignUp(),
        '/Cart': (BuildContext context) => new Cart(),
        '/Product': (BuildContext context) => new ProductPage(),
      },
      darkTheme: new ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        buttonColor: Colors.cyanAccent,
        appBarTheme: AppBarTheme(
          color: Colors.cyan[300],
        ),
        //scaffoldBackgroundColor: Colors.cyanAccent,
      ),
      theme: new ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.cyan,
        buttonColor: Colors.cyanAccent,
        appBarTheme: AppBarTheme(
          color: Colors.cyan[300],
        ),
        //scaffoldBackgroundColor: Colors.cyanAccent,
      ),
      home: new Splash(),
    );
  }
}