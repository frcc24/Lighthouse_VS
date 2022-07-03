// @dart=2.9

import 'dart:async';
// import 'dart:html';


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:lh_virtual_store/models/cart_model.dart';
import 'package:lh_virtual_store/models/user_model.dart';
import 'package:lh_virtual_store/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';


FutureOr<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
                useMaterial3: true,
                colorSchemeSeed: Colors.red[500],
                brightness: Brightness.light,

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


