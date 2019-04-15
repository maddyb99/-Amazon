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

class _ItemState extends State <ItemPage>{
  int count = 0;

  Widget BuildList() {
    return StreamBuilder(
        stream: Firestore.instance.collection("Products").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator(),);
          else {
            List<Widget> itemList = new List();
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              if (snapshot.data.documents[i]["catid"] == widget.id) {
                itemList.add(
                  Card(
                      child: ListTile(
                        isThreeLine: true,
                        leading: Hero(
                          tag: snapshot.data.documents[i]["id"],
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data.documents[i]["image"][0],
                            height: 50.0,
                            width: 50.0,
                            placeholder: (context, a) =>
                                Center(child: CircularProgressIndicator(),),
                          ),
                        ),
                        title: Text(snapshot.data.documents[i]["title"]),
                        subtitle: Text("Price: " +
                            snapshot.data.documents[i]["price"].toString()),
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
                                    id: snapshot.data.documents[i]["id"],
                                    color: widget.color,
                                    item: widget.items,)));
                        },
                      )
                  ),
                );
              }
            }
            print(itemList.length);
            return Column(
              children: itemList,
            );
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return BuildList();
  }
}

