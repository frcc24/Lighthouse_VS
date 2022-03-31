import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  void singUp({ required Map<String, dynamic> userData, required String pass,required  VoidCallback onSuccess,required  VoidCallback onFail}  ){
    isLoading = true;
    notifyListeners();
    _auth.createUserWithEmailAndPassword(
        email: userData['email'],
        password: pass

    ).then((user) async {
        _firebaseUser = _auth.currentUser!;
        onSuccess();
       await _saveUserData(userData);
        print(user);
        isLoading = false;
        notifyListeners();

    }).catchError((e){
      onFail();
      print(e);
      isLoading = false;
      notifyListeners();

    });

  }

  void singIn() async{
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 3));

    isLoading = false;
    notifyListeners();

  }

  void recoverPass(){

  }

  void isLoggedIn(){

  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async{
      this.userData = userData;
      await FirebaseFirestore.instance.collection("users").doc(_firebaseUser.uid).set(userData);
  }

}