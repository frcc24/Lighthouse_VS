import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: const Text("Cupom de Desconto"),
        leading: const Icon(Icons.wallet_giftcard),
        trailing: const Icon(Icons.add),
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite seu cupom",                  
                ),
                initialValue: "",
                onFieldSubmitted: (text){
                  FirebaseFirestore.instance.collection("coupons").doc(text).get().then((docSnapshot){
                    if(docSnapshot.data() != null){
                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Desconto de ${(docSnapshot.get("percent"))}% aplicado!"), backgroundColor: Colors.green,)
                      );
                    }else{
                      Scaffold.of(context).showSnackBar(
                          const SnackBar(content: Text("Cupom invalido"), backgroundColor: Colors.red,)
                      );
                    }
                  });
                },
              ),
          )
        ],
      ),
    );
  }
}
