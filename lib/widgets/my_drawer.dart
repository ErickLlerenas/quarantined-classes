import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/schedule.png"),
                fit: BoxFit.cover
              ),
              color: Colors.blue
            ),
          ),
          ListTile(
            title: Text('Quitar anuncios'),
            leading: Icon(Icons.shop),
            onTap: () {
              Navigator.pop(context);
       
            },
          ),
          
        ],
      ),
    );
  }
}
