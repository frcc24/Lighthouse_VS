import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          if (page != 3){
            Navigator.of(context).pop();
            controller.jumpToPage(page);
          }
          else{
            _launchURL();
          }
        },
        child: Container(
          height: 60.0,
          color: Colors.transparent,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(this.icon,
                color: controller.page?.round() == page ? Theme.of(context). primaryColor : Theme.of(context). secondaryHeaderColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text,
                  style: TextStyle(
                    fontSize: 16,
                    color: controller.page?.round() == page ? Theme.of(context). primaryColor : Theme.of(context). secondaryHeaderColor,
                  ) ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://www.lighthousegeek.com.br/?view=ecom/faq';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        //todo verificar se tem conexao com a internet antes de abrir o link
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }
}
