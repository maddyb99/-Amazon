import 'package:Not_Amazon/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawDrawer extends StatelessWidget {
  final FirebaseUser user;
  Color color;

  DrawDrawer({Key key, this.user, this.color});

  @override
  Widget build(BuildContext context) {
    return new DrawDrawerPage(user: user);
  }
}

class DrawDrawerPage extends StatefulWidget {
  DrawDrawerPage({Key key, this.user, this.color}) : super(key: key);
  Color color = Colors.cyan;
  final FirebaseUser user;

  @override
  _DrawDrawerState createState() => new _DrawDrawerState();
}

class _DrawDrawerState extends State<DrawDrawerPage> {
  static bool _night = false;

  Widget nightIcon() {
    return (_night) ? Icon(Icons.brightness_low) : Icon(Icons.brightness_high);
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
                    color: widget.color,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.sort),
                  title: Text('Category'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/Cat');
                  },
                  trailing: Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
          ),
          Divider(
            height: 2.0,
          ),
          SwitchListTile(
            value: _night,
            secondary: nightIcon(),
            title: Text('Night Mode'),
            onChanged: (newValue) {
              setState(() {
                _night = newValue;
                b = (_night) ? Brightness.dark : Brightness.light;
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
