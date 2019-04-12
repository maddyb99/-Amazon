import 'package:Not_Amazon/Drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Categories(title: 'Categories');
  }
}

class Categories extends StatefulWidget {
  Categories({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CategoryState createState() => new _CategoryState();
}

class _CategoryState extends State<Categories> {
  Color _appBarColor = Colors.cyan,
      _fabColor = Colors.cyan;
  ScrollActivityDelegate delegate;
  final pageController2 = PageController(
    initialPage: 0,
    keepPage: false,
  );


  Widget createCard1(String category) {
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
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0))),
    );
  }

  Widget createCard(DocumentSnapshot cat) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
              height: 200.0,
              width: double.maxFinite,
              child: CachedNetworkImage(
                  placeholder: (context, a) =>
                      Center(child: CircularProgressIndicator()),
                  imageUrl: cat['image'])),
        ],
      ),
    );
  }

  List<Widget> myList = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: new Scaffold(
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
          bottom: TabBar(tabs: [
            Tab(text: 'Electronics'),
            Tab(text: 'Clothes'),
            Tab(text: 'Furniture'),
            Tab(text: 'Home'),
          ]),
          backgroundColor: _appBarColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
        drawer: DrawDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/Login');
          },
          child: Icon(Icons.shopping_cart),
          backgroundColor: _fabColor,
        ),
        body: TabBarView(
          children: [
            StreamBuilder(
              stream: Firestore.instance.collection('Category').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(
                      value: null,
                    ),
                  );
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) =>
                      createCard(snapshot.data.documents[index]),
                );
              },
            ),
            createCard1("Electronics"),
            createCard1("Clothes"),
            createCard1("Furniture"),
          ],
        ),
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
      ),
    );
  }
}
