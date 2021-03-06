import 'package:flutter/material.dart';
import 'package:lh_virtual_store/widgets/cart_button.dart';

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
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          floatingActionButton: const CartButton(),
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          drawer: CustomDrawer(_pageController),
          appBar: AppBar(
            title: const Text('Coleções'),
            centerTitle: true,
          ),
          body: const ProductsTab(),
        ),
      ],
    );
  }
}
