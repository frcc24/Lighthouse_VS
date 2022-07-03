import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lh_virtual_store/models/user_model.dart';
import 'package:lh_virtual_store/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import '../tiles/drawer_tile.dart';
class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  const CustomDrawer(this.pageController);

  Widget _buildDrawerBack() => Container(
    // color: Colors.transparent,
    decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 194, 191, 191),
            Color.fromARGB(255, 8, 32, 50)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        )
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(80)),
      child: Drawer(
        child: Stack(
          children: <Widget> [
            _buildDrawerBack(),
            ListView(
              padding: EdgeInsets.only(left: 8.0, top: 32.0 ),
              children: <Widget> [
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  height: 170.0,
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 18.0,
                        left: 10.0,
                      child: Text("Lighthouse\nGeek Store",
                        style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                      ),
                      Positioned(
                          left: 10.0,
                          bottom: 0.0,
                          child: ScopedModelDescendant<UserModel>(
                           builder: (context, child, model) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Olá, ${!model.isLoggedIn() ? "nerd!" : model.userData['nome']}",
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      if(!model.isLoggedIn())
                                        {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                                        }else{
                                        model.signOut();
                                      }
                                    },
                                    child: Text(
                                      !model.isLoggedIn() ?
                                      "Entre ou cadastre-se +" : "Sair",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                           }),

                      ),
                    ],
                  ),
                ),
                const Divider(),
                DrawerTile(FontAwesomeIcons.home, "Inicio", pageController,0),
                const Divider(),
                DrawerTile(Icons.list, "Produtos", pageController,1),
                const Divider(),
                DrawerTile(FontAwesomeIcons.locationArrow, "Localizar a loja", pageController,2),
                const Divider(),
                DrawerTile(Icons.policy, "Politica de Privacidade", pageController,3),

              ],
            ),

          ],
        ),
      ),
    );
  }
}