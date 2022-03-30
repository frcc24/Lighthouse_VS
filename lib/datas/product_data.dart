
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{

  String id = "";
  String title = "";
  double price = 0.0;
  late List collections;
  late List images;

  String category = "";

  ProductData.fromDocument(DocumentSnapshot snapshot){
     id = snapshot.id;
     title = snapshot.get('title');
     collections = snapshot.get('collections');
     price = snapshot.get('price') + 0.0;
     images = snapshot.get('images');
  }

}