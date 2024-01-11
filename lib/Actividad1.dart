import 'package:actividad1/OnBoarding/vistaGestion.dart';
import 'package:actividad1/OnBoarding/vistaPerfil.dart';
import 'package:actividad1/Splash/vistaSplash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Main/vistaCreaPublicacion.dart';
import 'Main/vistaHome.dart';
import 'Main/vistaHome2.dart';
import 'Main/vistaPublicacion.dart';
import 'OnBoarding/vistaLogin.dart';
import 'OnBoarding/vistaLoginMovil.dart';
import 'OnBoarding/vistaRegistro.dart';
import 'SingleTone/DataHolder.dart';

class Actividad1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp = const MaterialApp();

    if(DataHolder().platformAdmin.isAndroidPlatform() ||
        DataHolder().platformAdmin.isIOSPlatform()) {
      materialApp = MaterialApp(title: "Actividad 1",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.aldrichTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routes: {
          '/vistalogin': (context) => vistaLoginMovil(),
          '/vistaregistro': (context) => vistaRegistro(),
          '/vistahome': (context) => vistaHome2(),
          '/vistaperfil': (context) => vistaPerfil(),
          '/vistasplash': (context) => vistaSplash(),
          '/vistapublicacion': (context) => vistaPublicacion(),
          '/vistacreapublicacion': (context) => vistaCreaPublicacion(),
        },
        initialRoute: '/vistalogin',
      );
    }

    else if(DataHolder().platformAdmin.isWebPlatform()){
      materialApp = MaterialApp(title: "Actividad 1",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.darkerGrotesqueTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routes: {
          '/vistalogin': (context) => vistaLogin(),
          '/vistaregistro': (context) => vistaRegistro(),
          '/vistahome': (context) => vistaHome(),
          '/vistaperfil': (context) => vistaPerfil(),
          '/vistasplash': (context) => vistaSplash(),
          '/vistapublicacion': (context) => vistaPublicacion(),
          '/vistacreapublicacion': (context) => vistaCreaPublicacion(),
          '/vistagestion': (context) => vistaGestion()
        },
        initialRoute: '/vistasplash',
      );
    }
    return materialApp;
  }
}