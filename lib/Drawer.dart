import 'package:Not_Amazon/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawDrawer extends StatefulWidget {
  final Color color;

  DrawDrawer({this.color = null});

  static bool _night = false;

  @override
  _DrawDrawerState createState() => _DrawDrawerState();
}

class _DrawDrawerState extends State<DrawDrawer> {
  Widget nightIcon() {
    return (DrawDrawer._night) ? Icon(Icons.brightness_low) : Icon(
        Icons.brightness_high);
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  child: new Center(child: new Text('Welcome')),
                  decoration: BoxDecoration(
                    color: widget.color == null ? Colors.cyan : widget.color,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacementNamed('/Home');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.sort),
                  title: Text('Category'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/CatList');
                  },
                ),
                Divider(height: 5.0,),
              ],
            ),
          ),
          Divider(
            height: 2.0,
          ),
          SwitchListTile(
            value: DrawDrawer._night,
            secondary: nightIcon(),
            title: Text('Night Mode'),
            onChanged: (newValue) {
              setState(() {
                DrawDrawer._night = newValue;
                b = (DrawDrawer._night) ? Brightness.dark : Brightness.light;
              });
            },
          ),
          Divider(
            height: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/Login');
            },
          ),
        ],
      ),
    );
  }
}