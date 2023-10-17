import 'package:actividad1/Home/vistaHome.dart';
import 'package:actividad1/OnBoarding/vistaPerfil.dart';
import 'package:actividad1/Splash/vistaSplash.dart';
import 'package:flutter/material.dart';
import 'OnBoarding/vistaLogin.dart';
import 'OnBoarding/vistaRegistro.dart';

class Actividad1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp = MaterialApp(title: "Actividad 1",
      routes: {
        '/vistalogin':(context) => vistaLogin(),
        '/vistaregistro':(context) => vistaRegistro(),
        '/vistahome': (context) => vistaHome(),
        '/vistaperfil': (context) => vistaPerfil(),
        '/vistasplash': (context) => vistaSplash()
      },
      initialRoute: '/vistasplash',
    );

    return materialApp;
  }
}