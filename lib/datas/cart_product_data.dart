import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lh_virtual_store/datas/product_data.dart';

class CartProduct{

    String id = "";
    String category = "";
    String productId = "";
    int quantity = 0;
    String collection = "";

    late ProductData productData ;

    CartProduct();

    CartProduct.fromDocument(DocumentSnapshot document){
      id = document.id;
      category = document.get('category');
      productId = document.get('productId');
      quantity = document.get('quantity');
      collection = document.get('collection');
    }

    Map<String, dynamic> toMap(){

      return {
        "category":  category,
        "productId":  productId,
        "quantity":  quantity,
        "collection":  collection,
        "product": productData.toResumeMap()
      };
    }



}