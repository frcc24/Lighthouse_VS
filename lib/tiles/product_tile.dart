import 'package:flutter/material.dart';
import 'package:lh_virtual_store/datas/product_data.dart';

import '../screens/product_screen.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData productData;

  ProductTile(this.type, this.productData);

  @override
  Widget build(BuildContext context) {

      return InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductScreen(productData)));
        },
          child: Card(
            child: type == "grid" ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                      padding: EdgeInsets.all(4),
                    child: Image.network(productData.images[0], fit: BoxFit.scaleDown,))),

                Container(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(productData.title,
                            style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                          Text("R\$ ${productData.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),

                    )
                ),
              ],
            )
            : Row(
              children: [
                Flexible(flex: 1,
                child: Expanded(
                    child: Container(
                        padding: EdgeInsets.all(4),
                        child: Image.network(productData.images[0], fit: BoxFit.scaleDown,))),
                ),
                Flexible(flex: 1,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(productData.title,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("R\$ ${productData.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),),
                      Text("Coleções ${productData.collections}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),

                ),
                ),
              ],
            ),
        ),
      );

  }
}
