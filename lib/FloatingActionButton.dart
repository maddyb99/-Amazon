import 'package:flutter/material.dart';

class FABCart extends StatefulWidget {
  final color;
  final int items;

  FABCart({this.color = Colors.cyan, this.items = 0});

  @override
  _FABCartState createState() => _FABCartState();
}

class _FABCartState extends State<FABCart> {
  Widget itemCount() {
    if (widget.items > 0)
      return Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding:
            EdgeInsets.only(right: widget.items > 9 ? 6.0 : 13.0, bottom: 13.0),
        alignment: Alignment.bottomRight,
        child: Text(
          widget.items.toString(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 10.5,
          ),
        ),
      );
    else
      return SizedBox(
        width: 0.0,
        height: 0.0,
      );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/Cart');
      },
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: <Widget>[
          Icon(Icons.shopping_cart),
          itemCount(),
        ],
      ),
      backgroundColor: widget.color,
    );
  }
}

class FABCloseCart extends StatefulWidget {
  final color;

  FABCloseCart({this.color = Colors.cyan});

  @override
  _FABCloseCartState createState() => _FABCloseCartState();
}

class _FABCloseCartState extends State<FABCloseCart> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Icon(Icons.clear),
      backgroundColor: widget.color,
    );
  }
}
