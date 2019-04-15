import 'package:Not_Amazon/Drawer.dart';
import 'package:Not_Amazon/FloatingActionButton.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  ProductPage({this.id, this.color, this.item = 0});

  final int id, item;
  final Color color;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
          items: widget.item,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Hero(
                tag: widget.id,
                child: Container(
                  width: double.maxFinite,
                  height: 300.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/products/iphone.PNG"),
                        fit: BoxFit.contain),
                  ),
                ),
              ),
              Divider(
                height: 5.0,
              ),
            ],
          ),
        ));
  }
}
