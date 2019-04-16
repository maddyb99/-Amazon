import 'package:Not_Amazon/Drawer.dart';
import 'package:Not_Amazon/FloatingActionButton.dart';
import 'package:Not_Amazon/Screens/Categories.dart';
import 'package:Not_Amazon/Screens/ItemList.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new CategoryListPage(title: 'CategoryList');
  }
}

class CategoryListPage extends StatefulWidget {
  CategoryListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CategoryListState createState() => new _CategoryListState();
}

class _CategoryListState extends State<CategoryListPage>
    with TickerProviderStateMixin {
  Color _appBarColor = Colors.cyan, _fabColor = Colors.cyan;
  ScrollActivityDelegate delegate;
  List<Widget> tab;
  TabController _tabController;
  int _itemCount, _categoryid, _pid;

  PageController _pageController = PageController(
    initialPage: 0,
  );

  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _itemCount = 0;

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
                    imageUrl: cat['image'])),
            elevation: 0.0,
          ),
          ItemPage(
              fn: addCart, color: _appBarColor, items: _itemCount, id: _pid)
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
          while (!snapshot.hasData) update(snapshot.data.documents);
        });
  }

  Widget tabs() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 50.0),
      child: StreamBuilder(
        stream: Firestore.instance.collection('Category').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                value: null,
              ),
            );
          tab = new List<Widget>.generate(
            snapshot.data.documents.length,
            (i) => FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Category(initpage: i)));
                  },
                  child: Row(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Hero(
                            tag: "c" +
                                snapshot.data.documents[i]["id"].toString(),
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data.documents[i]['icon'],
                              height: 25.0,
                              width: 25.0,
                              placeholder: (context, a) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                            ),
                          )),
                      Text(snapshot.data.documents[i]['title']),
                    ],
                  ),
                ),
          );
          return Column(
            children: tab,
          );
        },
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
      drawer: DrawDrawer(color: _appBarColor),
      floatingActionButton: FABCart(color: _fabColor, items: _itemCount),
      body: tabs(),
      //backgroundColor: _backgroundColor,
    );
  }
}
