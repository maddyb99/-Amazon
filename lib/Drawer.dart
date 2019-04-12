import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawDrawer extends StatelessWidget {
  final FirebaseUser user;

  DrawDrawer({Key key, this.user});

  @override
  Widget build(BuildContext context) {
    return new DrawDrawerPage(user: user);
  }
}

class DrawDrawerPage extends StatefulWidget {
  DrawDrawerPage({Key key, this.user}) :super(key: key);

  final FirebaseUser user;

  @override
  _DrawDrawerState createState() => new _DrawDrawerState();
}

class _DrawDrawerState extends State<DrawDrawerPage> {
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

          Divider(height: 2.0,),
          SwitchListTile(
            value: false,
            title: Text('Night Mode'),
            onChanged: null,
          ),
          Divider(height: 2.0,),
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

/*
new Drawer(
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
              child: Column(
                children: <Widget>[
                  Divider(height: 2.0, ),
                  Row(
                    children: <Widget>[
                      Text('Night Mode'),
                      Align(
                        alignment: FractionalOffset.centerRight,
                        child: SwitchListTile(
                          value: false,
                          title: Text('Night Mode'),
                          onChanged: null,
                        ),
                      )
                    ],
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
            ),
          )
        ],
      ),
    );
 */