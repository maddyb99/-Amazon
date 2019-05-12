import 'package:Not_Amazon/Drawer.dart';
import 'package:Not_Amazon/FloatingActionButton.dart';
import 'package:Not_Amazon/Screens/ProductPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Hme extends StatelessWidget {
  final FirebaseUser user;

  Hme({this.user});

  @override
  Widget build(BuildContext context) {
    return new HomePage(title: 'Home', user: user);
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.user}) : super(key: key);

  final String title;
  final FirebaseUser user;
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomePage> {
  bool elecflag;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _search;
  ScrollController _controller = ScrollController(
    initialScrollOffset: 60.0,
    keepScrollOffset: true,
  );

  void initState() {
    _search = null;
    super.initState();
  }

  Widget buildList() {
    return StreamBuilder(
        stream:
        Firestore.instance.collection("Products").orderBy("id").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            List<Widget> itemList = new List();
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              if (_search == null ||
                  snapshot.data.documents[i]["title"]
                      .toLowerCase()
                      .contains(_search.toLowerCase())) {
                itemList.add(Card(
                  child: FlatButton(
                    child: Column(
                      children: <Widget>[
                        Hero(
                          tag:
                          "p" + snapshot.data.documents[i]["id"].toString(),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data.documents[i]["image"][0],
                            height: 50.0,
                            width: 50.0,
                            placeholder: (context, a) =>
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                          ),
                        ),
                        Center(
                            child: Text(snapshot.data.documents[i]["title"])),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ProductPage(
                                id: snapshot.data.documents[i]["id"],
                              )));
                    },
                  ),
                ));
              }
            }
            print(itemList.length);
            return Column(
              children: itemList,
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: new Image.asset(
            'assets/images/logo.png',
            color: Colors.black,
            fit: BoxFit.fill,
          ),
          //backgroundColor: Colors.black,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations
                    .of(context)
                    .openAppDrawerTooltip,
              );
            },
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
        drawer: DrawDrawer(),
        floatingActionButton: FABCart(),
        body: SingleChildScrollView(
          controller: _controller,
          child: Center(
            child: Container(
              width: 325.0,
              height: double.maxFinite,
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formkey,
                    child: TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Search Here",
                        //disabledBorder: InputBorder.,
                        //enabledBorder: InputBorder.none,
                      ),
                      autofocus: false,
                      onSaved: (input) => _search = input,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (input) {
                        setState(() {
                          _search = input;
                        });
                      },
                    ),
                  ),
                  buildList(),
                ],
              ),
            ),
          ),
        )
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
      //backgroundColor: _backgroundColor,
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
