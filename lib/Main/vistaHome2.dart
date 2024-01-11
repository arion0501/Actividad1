import 'package:actividad1/Custom/MenuBotones.dart';
import 'package:actividad1/Custom/VistaGridCelda.dart';
import 'package:actividad1/Custom/VistaLista.dart';
import 'package:actividad1/ObjetosFirestore/PublicacionesFS.dart';
import 'package:actividad1/OnBoarding/vistaLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../Custom/DrawerCustom.dart';
import '../SingleTone/DataHolder.dart';


class vistaHome2 extends StatefulWidget {

  @override
  State<vistaHome2> createState() => _vistaHomeState();
}

class _vistaHomeState extends State<vistaHome2> {

  FirebaseFirestore fb = FirebaseFirestore.instance;
  final List<PublicacionesFS> publicaciones = [];
  bool bIsList = false;

  @override
  void initState() {
    super.initState();
    descargarPublicaciones();
    loadGeolocator();
  }

  void loadGeolocator() async {
    Position pos = await DataHolder().geolocAdmin.determinePosition();
    print('--->>$pos');
    DataHolder().suscribeACambiosGPSUsuario();
  }

  void fHomeViewDrawerOntap(int indice) {
    if(indice == 0){
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil (
        MaterialPageRoute (builder: (BuildContext context) =>  vistaLogin()),
        ModalRoute.withName('/vistalogin'),
      );
    }
    else if(indice == 1){

    }
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
      appBar: AppBar(title: Text("Actividad1"),),
      body: Center(
        child: listaOCelda(bIsList),
      ),
      bottomNavigationBar: MenuBotones(evento: onBottonMenuPressed),
      drawer: DrawerCustom(onItemTap: fHomeViewDrawerOntap),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/vistacreapublicacion");
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
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

  void onItemListaClicked(int index) {
    DataHolder().selectedPost = publicaciones[index];
    DataHolder().saveSelectedPostInCache();
    Navigator.of(context).pushNamed('/vistapublicacion');
  }

  Widget? creadorDeListaPublicacion(BuildContext context, int index) {
    return vistaLista(sTexto: publicaciones[index].titulo,
      dTamanyoFuente: 30,
      iCodigoColor: Colors.pink,
      onItemListClickedFun: onItemListaClicked,
      iPosicion: index,
    );
  }

  Widget? creadorDeCeldaPublicacion(BuildContext context, int index) {
    return vistaGridCelda(
        publicaciones: publicaciones,
        onItemListClickedFun: onItemListaClicked
    );
  }

  Widget separadorLista(BuildContext context, int index) {
    return Divider();
  }
}
