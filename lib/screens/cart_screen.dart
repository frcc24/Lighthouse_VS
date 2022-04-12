import 'package:flutter/material.dart';
import 'package:lh_virtual_store/models/cart_model.dart';
import 'package:lh_virtual_store/models/user_model.dart';
import 'package:lh_virtual_store/screens/login_screen.dart';
import 'package:lh_virtual_store/tiles/cart_tile.dart';
import 'package:lh_virtual_store/widgets/cart_button.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Meu Carrinho"),
        centerTitle: true,
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int quantidadeProdutosCart = model.products.length;
                return Text("$quantidadeProdutosCart ${quantidadeProdutosCart == 1 ? "Item" : "Itens"}", style: TextStyle(fontSize: 17.0),);
              }

              ),
          ),
       ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if(model.isLoading && UserModel.of(context).isLoggedIn()){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if (!UserModel.of(context).isLoggedIn()){
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_shopping_cart_rounded, size: 150, color: Theme.of(context).primaryColor,),
                  SizedBox(height: 16,),
                  const Text("Faça o Login para adicionar Produtos", style: TextStyle(fontSize: 35.0, color: Colors.black87), textAlign: TextAlign.center,),
                  SizedBox(height: 16,),
                  FlatButton(
                      onPressed: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen())); },
                      child: Text("Entrar", style: TextStyle(color: Colors.white, fontSize: 24), ), color: Theme.of(context).primaryColor),
                ],
              ),
            );
          }
          else if(model.products == null || model.products.length == 0){
            return Center(child: Text("Carrinho Vazio!", style: TextStyle(fontSize: 35),));
          }
          else{
            return ListView(
              children: [
                Column(
                  children: model.products.map((product) {

                    return CartTile(product);
                  }
                  ).toList(),
                )
              ],
            );
          }
        },
        ),
      );
  }
}
