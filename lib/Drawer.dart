import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawDrawer extends StatelessWidget {
  DrawDrawer({this.user});

  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  child: new Center(child: new Text('Welcome ${user.email}')),
                  decoration: BoxDecoration(
                    color: Colors.cyan,
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
          Container(
            child: Align(
              alignment: FractionalOffset.bottomLeft,
              child: ListTile(
                leading: Icon(Icons.power_settings_new),
                title: Text('Logout'),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('/Login');
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
