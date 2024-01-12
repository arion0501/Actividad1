import 'package:flutter/material.dart';

class DrawerCustom extends StatelessWidget {

  Function (int indice)? onItemTap;

  DrawerCustom({Key? key,
    required this.onItemTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menú Inicio'),

          ),
          ListTile(
            title: const Text('Logout'),
            leading: Icon(Icons.logout, color: Colors.red,),
            onTap: () {
              onItemTap!(0);
            },
          ),
          ListTile(
            title: const Text('Mostrar Usuarios activos (5km)'),
            leading: Icon(Icons.map_rounded, color: Colors.red),
            onTap: () {
              onItemTap!(1);
            },
          ),
        ],
      ),
    );
  }
}