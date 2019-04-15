import 'package:Not_Amazon/Drawer.dart';
import 'package:Not_Amazon/FloatingActionButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Color _appBarColor = Colors.cyan[300];
  int _qty;

  void initState() {
    _qty = 0;
    super.initState();
  }

  List<Widget> cards;

  Widget cartCards() {
    return Card(
      //color: Colors.black,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.all(0.0),
        leading: Container(
          padding: EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/products/iphone.PNG"),
              fit: BoxFit.contain,
            ),
          ),
          width: 50.0,
          height: 50.0,
        ),
        title: Text("iPhone"),
        trailing: FlatButton(onPressed: null, child: Icon(Icons.delete)),
        subtitle: Row(
          children: <Widget>[
            Text("Qty:"),
            Container(
              height: 50.0,
              width: 50.0,
              child: FlatButton(
                  onPressed: () {
                    setState(() {
                      if (_qty > 0) _qty--;
                    });
                  },
                  child: Icon(Icons.remove)
              ),
            ),
            Text(_qty.toString()),
            Container(
              height: 50.0,
              width: 50.0,
              child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _qty++;
                    });
                  },
                  child: Icon(Icons.add)
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cartItems() {
    StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                value: null,
              ),
            );
          cards = new List<Widget>.generate(
            snapshot.data.documents.length,
            (i) => Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        width: double.maxFinite,
                        child: CachedNetworkImage(
                          placeholder: (context, a) =>
                              Center(child: CircularProgressIndicator()),
                          imageUrl: snapshot.data.documents[i]["name"],
                        ),
                      ),
                    ],
                  ),
                ),
          );
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
        actions: <Widget>[FlatButton(onPressed: null, child: Text("Checkout"))],
        backgroundColor: _appBarColor = Colors.cyan[300],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
      drawer: DrawDrawer(),
      floatingActionButton: FABCloseCart(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              cartCards(),
              cartCards(),
              cartCards(),
              cartCards(),
              cartCards(),
              cartCards(),
              cartCards(),
              cartCards(),
              cartCards(),
              cartCards(),
              cartCards(),
              cartCards(),
              cartCards(),
            ],
          ),
        ),
      ),
    );
  }
}
