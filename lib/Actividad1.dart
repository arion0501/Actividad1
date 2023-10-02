import 'package:actividad1/Registro&Login/vistaLogin.dart';
import 'package:flutter/material.dart';

class Actividad1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp = MaterialApp(title: "Actividad 1",
      routes: {
        '/vistalogin':(context) => vistaLogin(),
      },
      initialRoute: '/vistalogin',
    );

    return materialApp;
  }
}