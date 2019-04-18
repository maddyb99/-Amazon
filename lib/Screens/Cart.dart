import 'dart:async';

import 'package:Not_Amazon/Drawer.dart';
import 'package:Not_Amazon/FloatingActionButton.dart';
import 'package:Not_Amazon/Global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int _qty, cart;
  List<Widget> itemList = new List();

  void initState() {
    _qty = 0;
    cart = 0;
    getCart();
    super.initState();
  }

  Future<void> getCart() async {
    preference = Firestore.instance.collection("Products");
    psnapshot = await preference.getDocuments();
    cartreference = Firestore.instance.collection("/users/test/cart");
    cartsnapshot = await cartreference.getDocuments();
    setState(() {
      cart = cartsnapshot.documents.length;
    });
    itemList.clear();
    for (int i = 0; i < cart; i++)
      getItem(cartsnapshot.documents[i]);
  }

  void getItem(DocumentSnapshot cartItem) {
    for (int i = 0; i < psnapshot.documents.length; i++)
      if (psnapshot.documents[i]["id"] == cartItem["id"]) {
        _qty = cartItem["qty"];
        itemList.add(Card(
          //color: Colors.black,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.all(0.0),
            leading: Hero(
              tag: "p" +
                  psnapshot.documents[i]["id"].toString(),
              child: CachedNetworkImage(
                imageUrl: psnapshot.documents[i]["image"][0],
                height: 50.0,
                width: 50.0,
                placeholder: (context, a) =>
                    CircularProgressIndicator(),
              ),
            ),
            title: Text(psnapshot.documents[i]["title"]),
            trailing: FlatButton(onPressed: () {
              cartreference.document(cartItem.documentID).delete();
              Update();
              getCart();
              setState(() {});
            }, child: Icon(Icons.delete)),
            subtitle: Row(
              children: <Widget>[
                Text("Qty:"),
                Container(
                  height: 50.0,
                  width: 50.0,
                  child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (_qty > 1) _qty--;
                          cartreference.document(cartItem.documentID)
                              .updateData({'qty': _qty});
                          getCart();
                        });
                      },
                      child: Icon(Icons.remove)),
                ),
                Text(_qty.toString()),
                Container(
                  height: 50.0,
                  width: 50.0,
                  child: FlatButton(
                      onPressed: () {
                        setState(() {
                          _qty++;
                          cartreference.document(cartItem.documentID)
                              .updateData({'qty': _qty});
                          getCart();
                        });
                      },
                      child: Icon(Icons.add)),
                ),
              ],
            ),
          ),
        ));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Image.asset(
          'assets/images/logo.png', color: Colors.black, fit: BoxFit.fill,),
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
        actions: <Widget>[FlatButton(onPressed: null, child: Text("Checkout"))],
        backgroundColor: Colors.cyan[300],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
      drawer: DrawDrawer(),
      floatingActionButton: FABCloseCart(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: itemList,
          ),
        ),
      ),
    );
  }
}
