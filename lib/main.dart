// @dart=2.9

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lh_virtual_store/models/cart_model.dart';
import 'package:lh_virtual_store/models/user_model.dart';
import 'package:lh_virtual_store/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';


FutureOr<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return  ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              title: 'LH Virtual Store',
              theme: ThemeData(
                dividerColor: const Color.fromARGB(255, 44, 57, 75) ,
                accentColor: const Color.fromARGB(255, 51, 71, 86),
                primaryColor:  const Color.fromARGB(255, 255, 76, 41),
                secondaryHeaderColor: const Color.fromARGB(255, 210, 210, 210),
                primaryColorDark: const Color.fromARGB(255, 8, 32, 50),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        },

      ),
    );
  }
}


