import 'package:flutter/material.dart';

import '../tabs/home_tab.dart';
import '../tabs/products_tab.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          drawer: CustomDrawer(_pageController),
          appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text('Coleções'),
            centerTitle: true,
          ),
          body: ProductsTab(),
        ),
        Container(color: Colors.green,),
        Container(color: Colors.red,),
        Container(color: Colors.blue,),//
      ],
    );
  }
}
