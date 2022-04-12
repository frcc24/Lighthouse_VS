import 'package:lh_virtual_store/datas/cart_product_data.dart';
import 'package:lh_virtual_store/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class CartModel extends Model{

  List<CartProduct> products = [];
  UserModel user;
  bool isLoading = false;

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  CartModel(this.user);


 void addCartItem( CartProduct cartProduct) async{
   products.add(cartProduct);

   await FirebaseFirestore.instance.collection("users").doc(user.firebaseUser?.uid).collection("cart").add(cartProduct.toMap()).then((doc) {
     cartProduct.id = doc.id;
   });

   notifyListeners();

 }

 void removeCartProduct( CartProduct cartProduct){
   FirebaseFirestore.instance.collection("users").doc(user.firebaseUser?.uid).collection("cart").doc(cartProduct.id).delete();
   products.remove(cartProduct);

   notifyListeners();

 }

}