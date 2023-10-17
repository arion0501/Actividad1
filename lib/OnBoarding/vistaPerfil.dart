import 'package:actividad1/ObjetosFirestore/UsuariosFS.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class vistaPerfil extends StatelessWidget {

  late BuildContext _context;

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecEdad = TextEditingController();
  TextEditingController tecPeso = TextEditingController();
  TextEditingController tecColorOjos = TextEditingController();

  FirebaseFirestore fb = FirebaseFirestore.instance;

  void onClickCancelar() {

  }

  void onClickAceptar() async {
    UsuariosFS usuario = new UsuariosFS(nombre: tecNombre.text,
        edad: int.parse(tecEdad.text), peso: double.parse(tecPeso.text),
        colorOjos: tecColorOjos.text);
    
    String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
    await fb.collection("Usuarios").doc(uidUsuario).set(usuario.toFirestore());

    Navigator.of(_context).popAndPushNamed('/vistaHome');
  }

  @override
  Widget build(BuildContext context) {

    _context = context;

    throw UnimplementedError();
  }


}