import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lh_virtual_store/screens/products_screen.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  CategoryTile(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(documentSnapshot.get("icon")),
      ),
      title: Text(
        documentSnapshot.get("title"),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductsScreen(documentSnapshot)));
      },
    );
  }
}
