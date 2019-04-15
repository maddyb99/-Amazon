import 'package:flutter/material.dart';

class _ThemeData {
  static final _ThemeData _singleton = new _ThemeData._internal();

  factory _ThemeData(){
    return _singleton;
  }

  ThemeData theme;
  String lol = "Hahayes";

  _ThemeData._internal(){
    theme = new ThemeData(
        brightness: Brightness.dark
    );
  }
}

