import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lh_virtual_store/datas/cart_product_data.dart';
import 'package:lh_virtual_store/datas/product_data.dart';
import 'package:lh_virtual_store/models/cart_model.dart';

class CartTile extends StatelessWidget {

  CartProduct cartProduct;

  BuildContext context;

  CartTile(this.cartProduct, this.context);


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
          padding: const EdgeInsets.all(8.0),
          width: 120.0,
          child: Image.network(cartProduct.productData?.images[0]),
        ),
        Expanded(
            child: Container(

              padding: const EdgeInsets.all(8.0),
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(cartProduct.productData!.title, style: const TextStyle(fontSize: 20),),
                  Text(cartProduct.collection),
                  Text("R\$ ${cartProduct.productData!.price.toStringAsFixed(2)}"),

                  Row(
                    children: [
                      IconButton(
                          onPressed: cartProduct.quantity > 1 ? (){ CartModel.of(context).decProduct(cartProduct); } : null,
                          icon: const Icon(Icons.remove)),
                      Text(cartProduct.quantity.toString()),
                      IconButton(onPressed: (){ CartModel.of(context).incProduct(cartProduct);}, icon: Icon(Icons.add)),
                      FlatButton(onPressed: (){ CartModel.of(context).removeCartProduct(cartProduct);}, child: Text("remover"),)

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
