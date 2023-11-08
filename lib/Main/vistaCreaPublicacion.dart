import 'package:actividad1/ObjetosFirestore/PublicacionesFS.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Custom/A1TextField.dart';
import '../SingleTone/DataHolder.dart';

class vistaCreaPublicacion extends StatelessWidget {

  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController tecTitulo = TextEditingController();
  TextEditingController tecCuerpo = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          A1TextField(tecController: tecTitulo,
              labelText:'Escribe un titulo'),

          A1TextField(tecController: tecCuerpo,
              labelText:'Escribe un cuerpo'),

          Image.asset("Recursos/aiGenerated.png", width: 65),

          TextButton(onPressed: () {
            PublicacionesFS postNuevo = new PublicacionesFS(
              titulo: tecTitulo.text,
              cuerpo: tecCuerpo.text,
            );
            CollectionReference<PublicacionesFS> postsRef = db.collection("Post")
                .withConverter(
              fromFirestore: PublicacionesFS.fromFirestore,
              toFirestore: (PublicacionesFS post, _) => post.toFirestore(),
            );
            postsRef.add(postNuevo);
            Navigator.of(context).popAndPushNamed("/vistahome");
          },
              child: Text("Postear")
          )
        ],
      ),
    );
  }
}