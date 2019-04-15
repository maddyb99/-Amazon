import 'package:Not_Amazon/Screens/ProductPage.dart';
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
  @override
  Widget build (BuildContext context){
    return Card(
        child: ListTile(
          isThreeLine: true,
          leading: Hero(
            tag: widget.id,
            child: Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/products/iphone.PNG"),
                    fit: BoxFit.contain),
              ),
            ),
          ),
          title: Text("iPhone"),
          subtitle: Text("Price: Teri Aukaat k Bahar"),
          trailing: MaterialButton(
            elevation: 2.0,
            child: Text("add to cart"),
            onPressed: () {
              super.setState(widget.fn);
            },
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                ProductPage(
                  id: widget.id, color: widget.color, item: widget.items,)));
          },
        )
    );
  }
}

