import 'package:actividad1/Custom/VistaGridCelda.dart';
import 'package:actividad1/Custom/MenuBotones.dart';
import 'package:actividad1/Custom/VistaLista.dart';
import 'package:actividad1/ObjetosFirestore/PublicacionesFS.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class vistaHome extends StatefulWidget {

  @override
  State<vistaHome> createState() => _vistaHomeState();
}

class _vistaHomeState extends State<vistaHome> {

  FirebaseFirestore fb = FirebaseFirestore.instance;
  final List<PublicacionesFS> publicaciones = [];
  bool bIsList = false;

  @override
  void initState() {
    super.initState();
    descargarPublicaciones();
  }

  void onBottonMenuPressed(int indice) {
    setState(() {
      if(indice == 0){
        bIsList = true;
      }
      else if(indice == 1){
        bIsList = false;
      }
    });
  }

  void descargarPublicaciones() async {
    CollectionReference<PublicacionesFS> collection = fb.collection("Publicaciones")
        .withConverter(fromFirestore: PublicacionesFS.fromFirestore,
        toFirestore: (PublicacionesFS publicacionesFS, _) => publicacionesFS.toFirestore());

    QuerySnapshot<PublicacionesFS> querySnapshot = await collection.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      setState(() {
        publicaciones.add(querySnapshot.docs[i].data());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home',
          style: TextStyle(fontFamily: 'DelaGothicOne'),),),
      body: Center(
        child: listaOCelda(bIsList),
      ),
      bottomNavigationBar: menuBotones(evento: onBottonMenuPressed),
    );
  }

  Widget? listaOCelda(bool isList) {
    if (isList) {
      return ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: publicaciones.length,
        itemBuilder: creadorDeListaPublicacion,
        separatorBuilder: separadorLista,
      );
    }
    else {
      return creadorDeCeldaPublicacion(context, publicaciones.length);
    }
  }

  Widget? creadorDeListaPublicacion(BuildContext context, int index) {
    return vistaLista(sTexto: publicaciones[index].titulo,
      dTamanyoFuente: 60,
      iCodigoColor: 0,
    );
  }

  Widget? creadorDeCeldaPublicacion(BuildContext context, int index) {
    return vistaGridCelda(
      publicaciones: publicaciones,
    );
  }

  Widget separadorLista(BuildContext context, int index) {
    return Divider();
  }
}
