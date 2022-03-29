import 'package:flutter/material.dart';

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
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: Container(
          height: 60.0,
          color: Colors.transparent,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(this.icon,
                color: controller.page?.round() == page ? Theme.of(context). primaryColor : Colors.grey[700],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text,
                  style: TextStyle(
                    fontSize: 16,
                    color: controller.page?.round() == page ? Theme.of(context). primaryColor : Colors.grey[700],
                  ) ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
