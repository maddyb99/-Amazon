import 'package:Not_Amazon/Drawer.dart';
import 'package:Not_Amazon/FloatingActionButton.dart';
import 'package:Not_Amazon/Global.dart';
import 'package:Not_Amazon/Screens/Categories.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

  void initState() {
    if (csnapshot == null)
      Update(fn: refresh).updateData();
    tab = new List<Widget>();
    tabs();
    super.initState();
  }

  void refresh() {
    tabs();
    setState(() {});
  }

  void tabs() async {
    tab.clear();
    if (csnapshot == null) {
      tab.add(Center(
        child: CircularProgressIndicator(
          value: null,
        ),
      ));
    } else
      for (int i = 0; i < csnapshot.documents.length; i++)
        tab.add(
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Category(initpage: i)));
            },
            child: Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Hero(
                      tag: "c" + csnapshot.documents[i]["id"].toString(),
                      child: CachedNetworkImage(
                        imageUrl: csnapshot.documents[i]['icon'],
                        height: 25.0,
                        width: 25.0,
                        placeholder: (context, a) =>
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                      ),
                    )),
                Text(csnapshot.documents[i]['title']),
              ],
            ),
          ),
        );
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
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: _appBarColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                tab.clear();
                tab.add(Center(child: CircularProgressIndicator(),));
                setState(() {});
                Update(fn: refresh).updateData();
              },
              child: Icon(Icons.refresh)),
        ],
      ),
      drawer: DrawDrawer(color: _appBarColor),
      floatingActionButton: FABCart(color: _fabColor),
      body: Column(
        children: tab,
      ),
      //backgroundColor: _backgroundColor,
    );
  }
}
