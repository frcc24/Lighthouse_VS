import 'package:flutter/material.dart';
import 'package:lh_virtual_store/models/user_model.dart';
import 'package:lh_virtual_store/screens/new_user_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text("Entrar"),
          actions: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: IconButton(
                 onPressed: (){ Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NewUserScreen()));},
                 icon: Icon(Icons.group_add), color: Colors.white,),
             ),
          ],
        ),
      body: ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              if(model.isLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }
              return
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ListView(
                        children: [
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              padding: EdgeInsets.zero,
                              onPressed: (){
                                if(_emailController.text.isNotEmpty){
                                  model.recoverPass(_emailController.text);
                                  _scafoldKey.currentState!.showSnackBar(
                                      SnackBar(
                                        content: Text("Confira seu email ${_emailController.text} para resetar!!",
                                          style: TextStyle(color: Colors.blue),),
                                        backgroundColor: Colors.white70,
                                        duration: Duration(seconds: 2),
                                      ));
                                }else{
                                  _scafoldKey.currentState!.showSnackBar(
                                      const SnackBar(
                                        content: Text("Preencha o campo de email para recuperação!!",
                                          style: TextStyle(color: Colors.red),),
                                        backgroundColor: Colors.white70,
                                        duration: Duration(seconds: 2),
                                      ));
                                }
                              },
                              child: Text("Esqueci minha senha", style: TextStyle(color: Colors.blueAccent),),
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: RaisedButton(
                                color: Colors.red,
                                onPressed: (){
                                  if(_formKey.currentState!.validate())
                                  {}
                                  model.singIn(email: _emailController.text, pass: _passController.text, onSuccess: onSuccess, onFail: onFail);
                                },
                                child: Text("Entrar", style: TextStyle(color: Colors.white, fontSize: 18),),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                );
            },
      ),
    );
  }

  void onSuccess(){
    // _scafoldKey.currentState!.showSnackBar(
    //     SnackBar(
    //       content: Text("Usuario Logado com sucesso!",
    //         style: TextStyle(color: Colors.blue[900]),),
    //       backgroundColor: Colors.white70,
    //       duration: Duration(seconds: 2),
    //     ));

      Navigator.of(context).pop();


  }
  void onFail(){
    _scafoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Falha No login!!",
            style: TextStyle(color: Colors.red),),
          backgroundColor: Colors.white70,
          duration: Duration(seconds: 2),
        ));

    // Future.delayed((const Duration(seconds: 2))).then((value){
    //   Navigator.of(context).pop();
    // });

  }


}
