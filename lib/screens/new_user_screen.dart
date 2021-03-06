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
  final _scafoldKey = GlobalKey<ScaffoldState>();
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        // backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text(
          "Criar uma nova conta",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.login),
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          alignment: Alignment.center,
          child: Card(
            margin: EdgeInsets.all(32),
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Nome inv??lido";
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            hintText: "Digite seu Nome",
                            focusColor: Colors.red,
                            hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[400])),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (text) {
                          if (text!.isEmpty || !text.contains("@")) {
                            return "Email inv??lido";
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            hintText: "Digite seu e-mail",
                            focusColor: Colors.red,
                            hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[400])),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _passController,
                        validator: (text) {
                          this.password = text;
                          if (text!.isEmpty || text.length < 6) {
                            return "Senha invalida";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            hintText: "Digite sua senha",
                            focusColor: Colors.red,
                            hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[400])),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: (text) {
                          if (text!.isEmpty || text != this.password) {
                            return "Senhas digitadas sao diferentes";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            hintText: "Digite sua senha novamente",
                            focusColor: Colors.red,
                            hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[400])),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 50.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.redAccent,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Map<String, dynamic> userData = {
                                'nome': _nameController.text,
                                'email': _emailController.text,
                                'pass': _passController.text
                              };
                              model.singUp(
                                  userData: userData,
                                  pass: _passController.text,
                                  onSuccess: onSuccess,
                                  onFail: onFail);
                            }
                          },
                          child: Text(
                            "Criar conta",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        );
      }),
    );
  }

  void onSuccess() {
    _scafoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(
        "Usuario criado com sucesso!",
        style: TextStyle(color: Colors.blue[900]),
      ),
      backgroundColor: Colors.white70,
      duration: Duration(seconds: 2),
    ));

    Future.delayed((const Duration(seconds: 2))).then((value) {
      Navigator.of(context).pop();
    });
  }

  void onFail() {
    _scafoldKey.currentState!.showSnackBar(const SnackBar(
      content: Text(
        "Falha ao criar Usuario",
        style: TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.white70,
      duration: Duration(seconds: 2),
    ));

    // Future.delayed((const Duration(seconds: 2))).then((value){
    //   Navigator.of(context).pop();
    // });
  }
}
