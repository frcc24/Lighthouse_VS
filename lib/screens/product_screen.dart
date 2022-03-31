
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lh_virtual_store/datas/product_data.dart';

class ProductScreen extends StatelessWidget {

  final ProductData productData;

  ProductScreen(this.productData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
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
                  padding: EdgeInsets.all(16),
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
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
