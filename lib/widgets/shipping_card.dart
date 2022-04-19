import 'package:flutter/material.dart';
class ShippingCard extends StatelessWidget {
  const ShippingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: const Text("Calcular Frete"),
        leading: const Icon(Icons.location_history),
        // trailing: const Icon(Icons.add),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu CEP",
              ),
              initialValue: "",
              onFieldSubmitted: (text){

              },
            ),
          )
        ],
      ),
    );
  }
}
