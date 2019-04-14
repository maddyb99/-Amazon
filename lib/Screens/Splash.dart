import 'dart:async';

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
      backgroundColor: Colors.grey,
      body: new Center(
        child: Image.asset('assets/images/products/iphone.PNG'),
      ),
      // )
    );
  }
}
