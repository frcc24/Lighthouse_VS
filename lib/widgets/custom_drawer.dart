import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../tiles/drawer_tile.dart';
class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  Widget _buildDrawerBack() => Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 100, 100, 100),
            Colors.white
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        )
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                    Positioned(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                           Text("Olá nerd,",
                              style: TextStyle(
                                  fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text("Entre ou cadastre-se +",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                          ],
                        ),
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
              DrawerTile(Icons.power_off, "Logout", pageController,3),

            ],
          ),

        ],
      ),
    );
  }
}
