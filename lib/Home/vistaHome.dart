import 'package:actividad1/ObjetosFirestore/PublicacionesFS.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class vistaHome extends StatefulWidget {

  @override
  State<vistaHome> createState() => _vistaHomeState();
}

class _vistaHomeState extends State<vistaHome> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<PublicacionesFS> posts = [];

  @override
  void initState() {
    super.initState();
    descargarPublicaciones();
  }

  void descargarPublicaciones() async {
    CollectionReference<PublicacionesFS> collection = db.collection("Post")
        .withConverter(fromFirestore: PublicacionesFS.fromFirestore,
        toFirestore: (PublicacionesFS post, _) => post.toFirestore());

    QuerySnapshot<PublicacionesFS> querySnapshot = await collection.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      setState(() {
        posts.add(querySnapshot.docs[i].data());
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    Column columna = Column(children : [
      Padding(padding: EdgeInsets.symmetric(vertical: 15),
          child: Text('¡Bienvenido al Home!',
              style: TextStyle(fontSize: 22))
      ),
    ]
    );

    AppBar appBar = AppBar(
      title: Text('Home', style: TextStyle(fontFamily: 'DelaGothicOne')),
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
