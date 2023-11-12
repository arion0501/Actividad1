import 'package:actividad1/Custom/A1TextField.dart';
import 'package:actividad1/ObjetosFirestore/UsuariosFS.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class vistaGestion extends StatelessWidget {

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