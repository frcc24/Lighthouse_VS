import 'package:flutter/material.dart';
import 'package:lh_virtual_store/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/user_model.dart';

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({Key? key}) : super(key: key);


  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Criar uma nova conta"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: (){ Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));},
              icon: Icon(Icons.login), color: Colors.white,),
          ),

        ],
      ),
      body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if(model.isLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
            return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (text){
                          if (text!.isEmpty ) {
                            return "Nome inválido";
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0),  ),
                            hintText: "Digite seu Nome",
                            focusColor: Colors.red,
                            hintStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[400])
                        ),
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        controller: _emailController,
                        validator: (text){
                          if (text!.isEmpty || !text.contains("@")) {
                            return "Email inválido";
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0),  ),
                            hintText: "Digite seu e-mail",
                            focusColor: Colors.red,
                            hintStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[400])
                        ),
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        controller: _passController,
                        validator: (text){
                          this.password = text;
                          if(text!.isEmpty || text.length < 6) {
                            return "Senha invalida";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0),  ),
                            hintText: "Digite sua senha",
                            focusColor: Colors.red,
                            hintStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[400])
                        ),
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        validator: (text){
                          if(text!.isEmpty || text != this.password)
                          {
                            return "Senhas digitadas sao diferentes";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0),  ),
                            hintText: "Digite sua senha novamente",
                            focusColor: Colors.red,
                            hintStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[400])
                        ),
                      ),

                      SizedBox(
                        height: 50.0,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: RaisedButton(
                            color: Colors.red,
                            onPressed: (){
                              if(_formKey.currentState!.validate()){
                                Map<String, dynamic> userData = {
                                  'nome': _nameController.text,
                                  'email': _emailController.text,
                                  'pass': _passController.text
                                };
                              model.singUp(
                                  userData: userData,
                                  pass: _passController.text,
                                  onSuccess: onSuccess,
                                  onFail: onFail)  ;
                              }
                            },
                            child: Text("Criar conta", style: TextStyle(color: Colors.white, fontSize: 18),),
                          ),
                        ),
                      )
                    ],
                  ),
                )
            );
          }),

    );
  }

  void onSuccess(){

  }
  void onFail(){}
}
