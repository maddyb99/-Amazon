import 'package:flutter/material.dart';

Brightness b = Brightness.light;
ThemeData _themeData = ThemeData(
  brightness: b,
  primarySwatch: Colors.cyan,
  buttonColor: Colors.cyanAccent,
);

// ignore: camel_case_types
class _brightnessData extends StatefulWidget {
  @override
  __brightnessDataState createState() => __brightnessDataState();
}

// ignore: camel_case_types
class __brightnessDataState extends State<_brightnessData> {
  bool _nightMode = false;

  Widget _changeBrightness() {
    setState(() {
      _nightMode = !_nightMode;
      b = (_nightMode) ? Brightness.dark : Brightness.light;
    });
    return SizedBox(
      width: 0.0,
      height: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _changeBrightness();
  }
}
