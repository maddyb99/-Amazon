import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:Not_Amazon/Screens/ItemList.dart';

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
  int _Mode=0;
  Color _backgroundColor=Colors.white,_appBarColor=Colors.cyan,_fabColor=Colors.cyan;
  String _cat;
  ScrollActivityDelegate delegate;
  final pageController=PageController(
    initialPage: 0,
    keepPage: false,
  );
  void initState() {
    elecflag = false;
    super.initState();
  }
  Widget createCategory(String cat){
    return ExpandablePanel(
      header: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0,left: 5.0,right: 5.0),
          child: createCard(cat),
        ),
      ),
      expanded: FlatButton(
          onPressed: (){
            setState(() {
              _cat = cat;
              pageController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.linear);
            });
          },
          child: Text('Sublist for' + cat)
      ),
      //initialExpanded: false,
      tapHeaderToExpand: true,
      hasIcon: false,
    );
  }
  Widget createCard(String category) {
    return Card(
      child: Column(
        children: <Widget>[
          Hero(
            tag: category,
            child: Container(
                height: 200.0,
                width: double.maxFinite,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: new AssetImage('assets/images/categories/' +
                        category.toLowerCase() +
                        '.PNG'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
            ),
          ),
          new Center(child:Text(category)),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0))),
    );
  }
  Widget createBody(){
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            createCategory("Electronics"),
            createCategory("Clothes"),
            createCategory("Furniture"),
            createCategory("Gadget"),
          ]
        ),
      );
  }
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
      body: PageView(
        controller: pageController,
        children: <Widget>[
          createBody(),
          Items(cat: _cat),
        ],
        scrollDirection: Axis.horizontal,
        onPageChanged: (int page){
          if(pageController.page.round()==0)
            setState(() {
              _backgroundColor=Colors.white;
              _appBarColor=Colors.cyan;
              _fabColor=Colors.cyan;
            });
          else if(pageController.page.round()==1)
            if(_cat=='Electronics')
              setState(() {
                _backgroundColor=Colors.greenAccent[100];
                _appBarColor=Colors.lightGreen;
                _fabColor=Colors.lightGreen;
              });
            else if(_cat=='Clothes')
              setState(() {
                _backgroundColor=Colors.pinkAccent[100];
                _appBarColor=Colors.pink;

                _fabColor=Colors.pink;
              });
            else if(_cat=='Furniture')
              setState(() {
                _backgroundColor=Colors.brown[100];
                _appBarColor=Colors.brown;
                _fabColor=Colors.brown;
              });
            else if(_cat=='Gadget')
              setState(() {
                _backgroundColor=Colors.deepOrangeAccent[100];
                _appBarColor=Colors.deepOrangeAccent;
                _fabColor=Colors.deepOrangeAccent;
              });
        },
      ),
      backgroundColor: _backgroundColor,
    );
  }
}

class CoolCard extends StatelessWidget {
  String category;
  VoidCallback parentStateCb;

  CoolCard({@required this.category, @required this.parentStateCb});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: new FlatButton(
        onPressed: parentStateCb,
        child: new Column(
          //width: 150.0,
          children: <Widget>[
            Container(
                height: 200.0,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: new AssetImage('assets/images/categories/' +
                        category.toLowerCase() +
                        '.PNG'),
                    fit: BoxFit.contain,
                  ),
                )),
            new Text(category),
          ],
        ),
      ),

      ///elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
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