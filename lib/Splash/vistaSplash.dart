import 'package:actividad1/ObjetosFirestore/UsuariosFS.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class vistaSplash extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _vistaSplashState();
  }
}

class _vistaSplashState extends State<vistaSplash> {

  FirebaseFirestore fb = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    checkSesion();
  }
  void checkSesion() async {
    await Future.delayed(Duration(seconds: 3));

    if(FirebaseAuth.instance.currentUser != null) {
      String uidUser = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference<UsuariosFS> reference = fb.collection('Users')
          .doc(uidUser)
          .withConverter(fromFirestore: UsuariosFS.fromFirestore,
          toFirestore: (UsuariosFS usuario, _) => usuario.toFirestore());

      DocumentSnapshot<UsuariosFS> docSnap = await reference.get();
      UsuariosFS usuario = docSnap.data()!;

      if(usuario != null) {
        print("nombre login user: " + usuario.nombre);
        print("edad login user: " + usuario.edad.toString());
        Navigator.of(context).popAndPushNamed("/homeview");
      }
      else{
        Navigator.of(context).popAndPushNamed('perfilview');
      }
    }
    else
      Navigator.of(context).popAndPushNamed("/loginview");
  }
}
