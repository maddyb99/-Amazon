import 'package:Not_Amazon/Global.dart';
import 'package:flutter/material.dart';

class FABCart extends StatefulWidget {
  final color;

  FABCart({this.color = Colors.cyan});

  @override
  _FABCartState createState() => _FABCartState();
}

class _FABCartState extends State<FABCart> {
  int count;

  void initState() {
    count = 0;
    Update();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        count = cartsnapshot != null ? cartsnapshot.documents.length : 0;
      });
    });
    //count=cartsnapshot.documents.length;
    super.initState();
  }

  Widget itemCount() {
    setState(() {
      count = cartsnapshot != null ? cartsnapshot.documents.length : 0;
    });
    if (count > 0)
      return Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding:
        EdgeInsets.only(right: count > 9 ? 6.0 : 13.0, bottom: 13.0),
        alignment: Alignment.bottomRight,
        child: Text(
          count.toString(),
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
