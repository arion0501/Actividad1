import 'package:flutter/material.dart';

class vistaGestion extends StatefulWidget {

  @override
  State<vistaGestion> createState() => _vistaGestionState();
}

class _vistaGestionState extends State<vistaGestion> {

  void checkSession() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).popAndPushNamed("/vistasplash");
  }

  @override
  void initState() {
    checkSession();
  }

  @override
  Widget build(BuildContext context) {

    Column columna = Column(children: [
      // Separación Tabla
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Text('ACTIVIDAD 1', style: TextStyle(fontSize: 20, fontFamily: 'Lobster')),

      Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        ],)
    ],
        mainAxisAlignment: MainAxisAlignment.center
    );

    AppBar appBar = AppBar(
      title: Text('GESTIÓN', style: TextStyle(fontSize: 24, fontFamily: 'DelaGothicOne')),
      centerTitle: true,
      backgroundColor: Colors.amber,
      foregroundColor: Colors.deepOrange,
    );

    Scaffold scaf = Scaffold(
      body: columna,
      backgroundColor: Colors.lightGreen,
      appBar: appBar,
    );

    return scaf;
  }
}