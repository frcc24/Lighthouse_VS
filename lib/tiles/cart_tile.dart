import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lh_virtual_store/datas/cart_product_data.dart';
import 'package:lh_virtual_store/datas/product_data.dart';

class CartTile extends StatelessWidget {

  CartProduct cartProduct;

  CartTile(this.cartProduct);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: cartProduct.productData == null ?
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance.collection("products").doc(cartProduct.category)
                    .collection("items").doc(cartProduct.productId).get(),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        cartProduct.productData = ProductData.fromDocument(snapshot.data!);
                        return _buildContent();
                      } else{
                        return Container(
                          height: 70.0,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ) : _buildContent(),
      ),

    );
  }

  Widget _buildContent(){
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          width: 120.0,
          child: Image.network(cartProduct.productData.images[0]),
        ),
        Expanded(
            child: Container(

              padding: EdgeInsets.all(8.0),
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(cartProduct.productData.title, style: TextStyle(fontSize: 20),),
                  Text(cartProduct.collection),
                  Text("R\$ ${cartProduct.productData.price.toStringAsFixed(2)}"),

                  Row(
                    children: [
                      IconButton(onPressed: cartProduct.quantity > 1 ? (){ } : null, icon: Icon(Icons.remove)),
                      Text(cartProduct.quantity.toString()),
                      IconButton(onPressed: (){}, icon: Icon(Icons.add)),
                      FlatButton(onPressed: (){}, child: Text("remover"),)

                    ],
                  ),

                ],
              ),

            )
        )
      ],
    );
  }
}
