import 'package:flutter/material.dart';
import 'package:lh_virtual_store/datas/product_data.dart';

class ProductScreen extends StatelessWidget {

  final ProductData productData;

  ProductScreen(this.productData);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(4),
                  child: Image.network(productData.images[0], fit: BoxFit.scaleDown,))),
        ],
      ),
    );
  }
}
