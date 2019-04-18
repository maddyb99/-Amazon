import 'dart:async';

import 'package:Not_Amazon/Global.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() {
    return new SplashState();
  }
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    Update();
    //print(MediaQuery.of(context).size.height);
    //print(MediaQuery.of(context).size.width);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context)
          .pushReplacementNamed('/Login');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: new Center(
          child: Hero(
              tag: "logo", child: Image.asset('assets/images/logo.png')),
        ),
      ),
      // )
    );
  }
}
