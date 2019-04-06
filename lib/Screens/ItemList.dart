import 'package:flutter/material.dart';
import 'package:Not_Amazon/Screens/Home.dart';

class Items extends StatelessWidget {
  final String cat;
  Items({@required this.cat});
  @override
  Widget build(BuildContext context) {
    return new ItemPage(title: 'Home',category: cat);
  }
}

class ItemPage extends StatefulWidget {
  ItemPage({Key key, this.title,@required this.category}) : super(key: key);

  final String title;
  final String category;
  @override
  _ItemState createState() => new _ItemState(category: category);
}

class _ItemState extends State <ItemPage>{
  final String category;
  _ItemState({this.category});
  @override
  Widget build (BuildContext context){
    return  WillPopScope(
      onWillPop: null,
      child: new SingleChildScrollView(
          child:
          Hero(
            tag: category,
            child: Container(
              height: 100.0,
              width: double.maxFinite,
              decoration: new BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage('assets/images/categories/'+category.toLowerCase()+'.PNG'),
                  fit: BoxFit.contain,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
      ),
    );
  }
}

