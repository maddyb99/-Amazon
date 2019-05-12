import 'package:Not_Amazon/Global.dart';
import 'package:Not_Amazon/Screens/ProductPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  ItemPage({this.items, this.color, this.fn, this.id});

  final VoidCallback fn;
  final int id, items;
  final Color color;

  @override
  _ItemState createState() => new _ItemState();
}

class _ItemState extends State<ItemPage> {
  int count = 0;
  CollectionReference reference;
  QuerySnapshot psnapshot;
  List<Widget> itemList;

  void initState() {
    buildList();
    itemList = null;
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  void buildList() async {
    //initState();
    psnapshot =
    await preference.where("catid", isEqualTo: widget.id).getDocuments();
    refresh();
    itemList = new List();
    for (int i = 0; i < psnapshot.documents.length; i++) {
      itemList.add(
        Card(
            child: ListTile(
              isThreeLine: true,
              leading: Hero(
                tag: "p" + psnapshot.documents[i]["id"].toString(),
                child: CachedNetworkImage(
                  imageUrl: psnapshot.documents[i]["image"][0],
                  height: 50.0,
                  width: 50.0,
                  placeholder: (context, a) => CircularProgressIndicator(),
                ),
              ),
              title: Text(psnapshot.documents[i]["title"]),
              subtitle:
              Text("Price: " + psnapshot.documents[i]["price"].toString()),
              trailing: MaterialButton(
                elevation: 2.0,
                child: Text("Add to cart"),
                onPressed: () {
                  cartreference.add(
                      {'id': psnapshot.documents[i]["id"], 'qty': 1});
                  setState(() {});
                },
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProductPage(
                          id: psnapshot.documents[i]["id"],
                          color: widget.color,
                          item: widget.items,
                        )));
              },
            )),
      );
    }
    //print(itemList.length);
    /*StreamBuilder(
        stream: Firestore.instance.collection("Products").psnapshots(),
        builder: (context, psnapshot) {
          if (!psnapshot.hasData)
            return Center(child: CircularProgressIndicator(),);
          else {
            List<Widget> itemList = new List();
            for (int i = 0; i < psnapshot.data.documents.length; i++) {
              if (psnapshot.data.documents[i]["catid"] == widget.id) {
                itemList.add(
                  Card(
                      child: ListTile(
                        isThreeLine: true,
                        leading: Hero(
                          tag: "p" +
                              psnapshot.data.documents[i]["id"].toString(),
                          child: CachedNetworkImage(
                            imageUrl: psnapshot.data.documents[i]["image"][0],
                            height: 50.0,
                            width: 50.0,
                            placeholder: (context, a) =>
                                Center(child: CircularProgressIndicator(),),
                          ),
                        ),
                        title: Text(psnapshot.data.documents[i]["title"]),
                        subtitle: Text("Price: " +
                            psnapshot.data.documents[i]["price"].toString()),
                        trailing: MaterialButton(
                          elevation: 2.0,
                          child: Text("Add to cart"),
                          onPressed: () {
                            super.setState(widget.fn);
                          },
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) =>
                                  ProductPage(
                                    id: psnapshot.data.documents[i]["id"],
                                    color: widget.color,
                                    item: widget.items,)));
                        },
                      )
                  ),
                );
              }
            }
            return Column(
              children: itemList,
            );
          }
        }
    );*/
  }

  @override
  Widget build(BuildContext context) {
    if (itemList != null)
      return Column(
        children: itemList,
      );
    else
      return CircularProgressIndicator();
  }
}
