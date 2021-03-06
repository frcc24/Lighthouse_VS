import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lh_virtual_store/datas/product_data.dart';
import 'package:lh_virtual_store/tiles/product_tile.dart';

import '../widgets/cart_button.dart';

class ProductsScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  ProductsScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: CartButton(),
          appBar: AppBar(
            // backgroundColor: Theme.of(context).primaryColor,
            title: Text(snapshot.get("title")),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [Icon(Icons.grid_on), Icon(Icons.list)],
              indicatorColor: Colors.white,
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("products")
                  .doc(snapshot.id)
                  .collection("items")
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                } else {
                  return TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      GridView.builder(
                        padding: const EdgeInsets.all(4.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ProductData data = ProductData.fromDocument(
                              snapshot.data!.docs[index]);
                          data.category = this.snapshot.id;
                          return ProductTile("grid", data);
                        },
                      ),
                      ListView.builder(
                          padding: EdgeInsets.all(4),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ProductData data = ProductData.fromDocument(
                                snapshot.data!.docs[index]);
                            data.category = this.snapshot.id;
                            return ProductTile("list", data);
                          }),
                    ],
                  );
                }
              }),
        ));
  }
}
