import 'package:actividad1/Home/vistaHome.dart';
import 'package:actividad1/Registro&Login/vistaLogin.dart';
import 'package:flutter/material.dart';
import 'Registro&Login/vistaRegistro.dart';

class Actividad1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp = MaterialApp(title: "Actividad 1",
      routes: {
        '/vistalogin':(context) => vistaLogin(),
        '/vistaregistro':(context) => vistaRegistro(),
        '/vistahome': (context) => vistaHome()
      },
      initialRoute: '/vistahome',
    );

    return materialApp;
  }
}