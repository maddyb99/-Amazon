import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

QuerySnapshot csnapshot, psnapshot, cartsnapshot, usersnapshot;
CollectionReference preference, creference, cartreference, userreference;

class Update {
  VoidCallback fn;

  Update({@required this.fn});

  void initState() {
    updateData();
  }

  Future<void> updateData() async {
    preference = Firestore.instance.collection("Products");
    psnapshot = await preference.getDocuments();
    creference = Firestore.instance.collection("Category");
    csnapshot = await creference.getDocuments();
    userreference = Firestore.instance.collection("users");
    usersnapshot = await userreference.getDocuments();
    cartreference = Firestore.instance.collection("/users/test/cart");
    cartsnapshot = await creference.getDocuments();
    fn();
  }
}
