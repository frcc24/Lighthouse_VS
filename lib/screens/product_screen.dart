
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lh_virtual_store/datas/product_data.dart';

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
                      onPressed: collection != "" ? (){} : null,
                      child: Text("Colocar no carrinho", style: TextStyle( fontSize: 16.0, color: Colors.white),),
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
