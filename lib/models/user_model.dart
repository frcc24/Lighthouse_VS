import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _firebaseUser = null;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    loadCurrentUser();

  }

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
      onFail( );
      print("\n===============\nErro na criacao do usuario: $e\n=================\n");
      isLoading = false;
      notifyListeners();

    });

  }

  void singIn({ required String email, required String pass,required  VoidCallback onSuccess,required  VoidCallback onFail}  ) async {
    isLoading = true;
    notifyListeners();

     _auth.signInWithEmailAndPassword(email: email, password: pass).then((user) async{
       _firebaseUser = _auth.currentUser!;
        onSuccess();
       print("\n===============\nLogin usuario: $_firebaseUser\n=================\n");
       await loadCurrentUser();
       isLoading = false;
       notifyListeners();

    }).catchError((e){

       onFail( );
       print("\n===============\nErro no Login do usuario: $e\n=================\n");
       isLoading = false;
       notifyListeners();


    });


    isLoading = false;
    notifyListeners();

  }

  void recoverPass(){

  }

  bool isLoggedIn(){
    if(_firebaseUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async{
      this.userData = userData;
      await FirebaseFirestore.instance.collection("users").doc(_firebaseUser!.uid).set(userData);
  }

  Future<Null> loadCurrentUser() async{

    if(_firebaseUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
          "users").doc(_firebaseUser!.uid).get();
      if(userDoc.exists){
        userData = userDoc.data() as Map<String, dynamic> ;
      }
      print("\n===============\nNome usuario: ${userData['nome']}\n=================\n");
    }


  }



  void signOut() async{
    await _auth.signOut();
    userData = {};
    _firebaseUser = null;
    notifyListeners();

  }

}