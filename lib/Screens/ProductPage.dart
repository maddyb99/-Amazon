import 'package:Not_Amazon/Drawer.dart';
import 'package:Not_Amazon/FloatingActionButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  ProductPage({this.id, this.color, this.item = 0});

  final int id, item;
  final Color color;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  PageController controller = new PageController(initialPage: 0);

  Widget buildItem() {
    return StreamBuilder(
        stream: Firestore.instance.collection("Products").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            List<Widget> itemList = new List(),
                imageList = new List();
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              if (snapshot.data.documents[i]["id"] == widget.id) {
                for (int j = 0;
                j < snapshot.data.documents[i]["image"].length;
                j++) {
                  imageList.add(
                    Hero(
                      tag: "p" + snapshot.data.documents[i]["id"].toString(),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data.documents[i]["image"][j],
                        height: 300.0,
                        width: double.maxFinite,
                        placeholder: (context, a) =>
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                      ),
                    ),
                  );
                }
                itemList.add(
                  Container(
                    width: double.maxFinite,
                    height: 300.0,
                    child: Stack(
                      children: <Widget>[
                        PageView(
                          children: imageList,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.chevron_right,
                            size: 35.0,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.chevron_left,
                            size: 35.0,
                          ),
                        )
                      ],
                    ),
                  ),
                );
                itemList.add(Divider(
                  height: 5.0,
                ));
                itemList.add(Row(
                  children: <Widget>[
                    Text(snapshot.data.documents[i]["title"]),
                  ],
                ));
              }
            }
            return Column(
              children: itemList,
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          backgroundColor: widget.color,
        ),
        drawer: DrawDrawer(),
        floatingActionButton: FABCart(
          color: widget.color,
        ),
        body: SingleChildScrollView(
          child: buildItem(),
        ));
  }
}
