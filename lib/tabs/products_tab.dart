import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lh_virtual_store/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder <QuerySnapshot> (
        future: FirebaseFirestore.instance.collection("products").get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
           return Container(
               alignment: Alignment.center,
               child: const CircularProgressIndicator(),
           );
          } else{
            return ListView(
              children: snapshot.data!.docs.map(
                  (doc) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CategoryTile(doc),
                    );
                  }
              ).toList()
            );
          }
        }
    );
  }
}
