import 'dart:async';

import 'package:Not_Amazon/Drawer.dart';
import 'package:Not_Amazon/FloatingActionButton.dart';
import 'package:Not_Amazon/Screens/ItemList.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  Category({this.initpage});

  final int initpage;

  @override
  Widget build(BuildContext context) {
    return new Categories(title: 'Categories', initpage: initpage,);
  }
}

class Categories extends StatefulWidget {
  Categories({Key key, this.title, this.initpage}) : super(key: key);
  final int initpage;
  final String title;

  @override
  _CategoryState createState() => new _CategoryState();
}

class _CategoryState extends State<Categories> with TickerProviderStateMixin {
  Color _appBarColor = Colors.cyan,
      _fabColor = Colors.cyan;
  ScrollActivityDelegate delegate;
  List<Widget> tab, cards;
  TabController _tabController;
  int _itemCount, _pid, _length;
  CollectionReference reference;
  QuerySnapshot snapshot;
  bool _loaded;
  PageController _pageController;

  void initState() {
    _loaded = false;
    tabs();
    _itemCount = widget.initpage;
    print(widget.initpage);
    _pageController = PageController(
      initialPage: widget.initpage,
    );
    refresh();
    super.initState();
  }

  Widget createCard(DocumentSnapshot cat) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
                height: 200.0,
                width: double.maxFinite,
                child: CachedNetworkImage(
                    placeholder: (context, a) =>
                        Center(child: CircularProgressIndicator()),
                    imageUrl: cat['image'])
            ),
            elevation: 0.0,
          ),
          ItemPage(
              fn: addCart,
              color: _appBarColor,
              items: _itemCount,
              id: cat["id"])
        ],
      ),
    );
  }

  void addCart() {
    setState(() {
      _itemCount++;
    });
  }

  void update(DocumentSnapshot snapshot) {
    setState(() {
      //_snapshot=snapshot;
    });
  }

  void refresh() {
    StreamBuilder(
        stream: Firestore.instance.collection('Category').snapshots(),
        builder: (context, snapshot) {
          while (!snapshot.hasData)
            update(snapshot.data.documents);
        }
    );
  }

  // ignore: missing_return
  Future<void> tabs() async {
    reference = Firestore.instance.collection("Category");
    snapshot = await reference.getDocuments();
    setState(() {
      _loaded = true;
      _appBarColor =
          Color(snapshot.documents[widget.initpage]['color']);
      _fabColor = Color(snapshot.documents[widget.initpage]['color']);
    });
    _length = snapshot.documents.length;
    _tabController =
        TabController(
            length: _length, vsync: this, initialIndex: widget.initpage);
    tab = new List();
    for (int i = 0; i < _length; i++) {
      tab.add(
        Tab(
          child: Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Hero(
                    tag: "c" +
                        snapshot.documents[i]["id"].toString(),
                    child: CachedNetworkImage(
                      imageUrl: snapshot.documents[i]['icon'],
                      height: 25.0,
                      width: 25.0,
                      placeholder: (context, a) =>
                          Center(child: CircularProgressIndicator(),),
                    ),
                  )
              ),
              Text(snapshot.documents[i]['title']),
            ],
          ),
        ),
      );
    }
    pages();
  }

  Widget tabcreate() {
    if (_loaded)
      return TabBar(
          tabs: tab,
          isScrollable: true,
          controller: _tabController,
          onTap: (int tab) {
            _pageController.animateToPage(
                tab, duration: Duration(milliseconds: 300),
                curve: Curves.linear);
          }
      );
    else
      return CircularProgressIndicator();
  }

  void pages() {
    cards = new List();
    for (int i = 0; i < _length; i++) {
      cards.add(createCard(snapshot.documents[i]));
    }
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
              tooltip: MaterialLocalizations
                  .of(context)
                  .openAppDrawerTooltip,
            );
          },
        ),
        bottom: tabcreate(),
        backgroundColor: _appBarColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
      drawer: DrawDrawer(color: _appBarColor),
      floatingActionButton: FABCart(color: _fabColor, items: _itemCount),
      body: PageView(
        controller: _pageController,
        children: cards,
        onPageChanged: (int page) {
          setState(() {
            _appBarColor =
                Color(snapshot.documents[page.round()]['color']);
            _fabColor = Color(snapshot.documents[page.round()]['color']);
            if (_tabController.animation.value.round() != page)
              _tabController.animateTo(page);
            _pid = snapshot.documents[page.round()]['id'];
          });
        },
      ),
      //backgroundColor: _backgroundColor,
    );
  }
}
