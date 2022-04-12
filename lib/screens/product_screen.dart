
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lh_virtual_store/datas/cart_product_data.dart';
import 'package:lh_virtual_store/datas/product_data.dart';
import 'package:lh_virtual_store/models/cart_model.dart';
import 'package:lh_virtual_store/models/user_model.dart';
import 'package:lh_virtual_store/screens/cart_screen.dart';
import 'package:lh_virtual_store/screens/login_screen.dart';

import '../widgets/cart_button.dart';

class ProductScreen extends StatefulWidget {

  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(this.product) ;

}

class _ProductScreenState extends State <ProductScreen>{

  final ProductData productData;
  String collection = "";

  _ProductScreenState(this.productData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CartButton(),

      appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(productData.title),
            centerTitle: true,
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                    aspectRatio: 1.5,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                          aspectRatio: 01
                      ),
                      items: productData.images.map((url){
                        return Image.network(url.toString());
                      }).toList(),
                    ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productData.title,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    Text("R\$ ${productData.price.toStringAsFixed(2)}",
                      style:  const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text("Coleções",
                      style:  TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                        child: GridView(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          scrollDirection: Axis.horizontal,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.4,
                          ),
                          children:
                            productData.collections.map(
                                    (s) {
                              return GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                      border: Border.all(
                                        color: s == collection ? Colors.red : Colors.grey,
                                        width: 2.0,
                                      )
                                  ),
                                  width: 50.0,
                                  alignment: Alignment.center,
                                  child: Text(s),
                                ),
                                onTap: (){
                                  setState(()
                                  {collection = s;});
                                },
                              );
                            }
                            ).toList(),
                        ),
                    ),
                    const SizedBox(height: 16.0,),
                    SizedBox(height: 44.0,
                    child: RaisedButton(
                      onPressed: collection != "" ? (){
                        if(UserModel.of(context).isLoggedIn()){

                          CartProduct cartProduct = CartProduct();
                          cartProduct.collection = collection;
                          cartProduct.quantity = 1;
                          cartProduct.productId = productData.id;
                          cartProduct.category = productData.category;

                          cartProduct.productData = productData;

                          CartModel.of(context).addCartItem(cartProduct);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CartScreen()));


                        }else{
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
                        }
                      } : null,
                      child: Text(UserModel.of(context).isLoggedIn() ? "Colocar no carrinho" : "Entre para comprar", style: TextStyle( fontSize: 16.0, color: Colors.white),),
                      color: Colors.red,
                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }


}
