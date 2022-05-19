import 'package:flutter/material.dart';
import 'package:lh_virtual_store/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {

  final VoidCallback buy;

   CartPrice(this.buy, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ScopedModelDescendant<CartModel>(
            builder: (context, child, model) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Resumo do Pedido", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w500),),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal"),
                      Text("R\$ 00,00"),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Desconto"),
                      Text("R\$ 00,00"),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Entrega"),
                      Text("R\$ 00,00"),
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 14,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total", style: TextStyle(fontWeight: FontWeight.w500),),
                      Text("R\$ 00,00", style: TextStyle(color: Colors.blueAccent, fontSize: 16),),
                    ],
                  ),
                  SizedBox(height: 12),
                  RaisedButton(onPressed: buy,
                    child: Text("Finalizar Pedido"),
                  color: Colors.blueAccent,
                    textColor: Colors.white70,
                  ),



                ],
              );
            }
          ),
          ),
        );

  }
}
