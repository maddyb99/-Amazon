import 'package:flutter/material.dart';

class Hme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new HomePage(title: 'Home');
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomePage> {
  bool elecflag;
  Color _backgroundColor=Colors.white,_appBarColor=Colors.cyan,_fabColor=Colors.cyan;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('!Amazon'),
        //backgroundColor: Colors.black,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: _appBarColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            DrawerHeader(
              child: new Center(child: new Text('Welcome')),
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/Cat');
              },
              child: new Row(
                children: <Widget>[
                  Icon(Icons.category),
                  Text('Categories')
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/Login');
        },
        child: Icon(Icons.shopping_cart),
        backgroundColor: _fabColor,
      ),
      body:
      Text("Homepage"),
      /*PageView(
        controller: pageController,
        children: <Widget>[
          createCategory("Electronics"),
          createCategory("Clothes"),
          createCategory("Furniture"),
          createCategory("Gadget"),
        ],
        scrollDirection: Axis.horizontal,
        onPageChanged: (int page){
          if(pageController.page.round()==0)
            setState(() {
              _backgroundColor=Colors.greenAccent[100];
              _appBarColor=Colors.lightGreen;
              _fabColor=Colors.lightGreen;
            });
          else if(pageController.page.round()==1)
            setState(() {
              _backgroundColor=Colors.pinkAccent[100];
              _appBarColor=Colors.pink;
              _fabColor=Colors.pink;
            });
          else if(pageController.page.round()==2)
            setState(() {
              _backgroundColor=Colors.brown[100];
              _appBarColor=Colors.brown;
              _fabColor=Colors.brown;
            });
          else if(pageController.page.round()==3)
            setState(() {
              _backgroundColor=Colors.deepOrangeAccent[100];
              _appBarColor=Colors.deepOrangeAccent;
              _fabColor=Colors.deepOrangeAccent;
            });
        },
      ),*/
      backgroundColor: _backgroundColor,
    );
  }
}

/*
class ItemPage extends StatelessWidget{
  String category;
  VoidCallback parentStateCb;
  ItemPage({@required this.category,@required parentStateCb});
  @override
  Widget build(BuildContext context){
    return Hero(
      tag: category,
      child: Container(
        height: 100.0,
        width: double.maxFinite,
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: new AssetImage('assets/images/categories/'+category.toLowerCase()+'.PNG'),
            fit: BoxFit.contain,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
*/