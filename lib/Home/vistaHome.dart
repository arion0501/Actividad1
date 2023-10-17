import 'package:actividad1/ObjetosFirestore/PublicacionesFS.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class vistaHome extends StatefulWidget {

  @override
  State<vistaHome> createState() => _vistaHomeState();
}

class _vistaHomeState extends State<vistaHome> {

  FirebaseFirestore db = FirebaseFirestore.instance;
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
    CollectionReference<PublicacionesFS> collection = db.collection("Publicaciones")
        .withConverter(fromFirestore: PublicacionesFS.fromFirestore,
        toFirestore: (PublicacionesFS publicacionesFS, _) => publicacionesFS.toFirestore());

    QuerySnapshot<PublicacionesFS> querySnapshot = await collection.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      setState(() {
        posts.add(querySnapshot.docs[i].data());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home',
            style: TextStyle(fontFamily: 'DelaGothicOne')),),
      body: Center(
            child: listaOCelda(bIsList),
          ),
      bottomNavigationBar: BottomMenu(evento: onBottonMenuPressed),
    );
  }

  Widget? creadorDeListaPublicacion(BuildContext context, int index) {
    return PostCellView(sText: posts[index].titulo,
      dFontSize: 60,
      iColorCode: 0,
    );
  }

  Widget? creadorDeCeldaPublicacion(BuildContext context, int index) {
    return PostGridCellView(
      post: posts,
    );
  }

}
