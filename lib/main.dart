// @dart=2.9

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
      child: MaterialApp(
        title: 'LH Virtual Store',
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.red[900],

        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}


