// @dart=2.9

import 'dart:async';

// import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lh_virtual_store/models/cart_model.dart';
import 'package:lh_virtual_store/models/user_model.dart';
import 'package:lh_virtual_store/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'firebase_options.dart';

FutureOr<void> main() async {
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
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              title: 'LH Virtual Store',
              theme: ThemeData(
                  useMaterial3: true,
                  colorSchemeSeed: const Color(0xffff4c29),
                  scaffoldBackgroundColor: const Color(0xffd2d2d2),
                  textTheme: TextTheme(
                      titleSmall: TextStyle(
                        color: const Color(0xff082032),
                      ),
                      titleMedium: TextStyle(
                        color: const Color(0xff082032),
                      )),
                  appBarTheme: AppBarTheme(
                      backgroundColor: const Color(0xffff4c29),
                      elevation: 0,
                      foregroundColor: Colors.white70)),
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
