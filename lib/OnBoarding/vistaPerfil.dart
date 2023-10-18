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

    Navigator.of(_context).popAndPushNamed('/vistahome');
  }

  @override
  Widget build(BuildContext context) {

    _context = context;

    return Scaffold(
      backgroundColor: Colors.lightGreen,

      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        shadowColor: Colors.amber,
      ),

      body: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Text("Bienvenido a tu perfil", style: TextStyle(fontSize: 25)),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 14),
            child: Flexible(child: SizedBox(width: 400, child: TextField(
              // textAlign: TextAlign.center,
              controller: tecNombre,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escribe tu nombre',
                  fillColor: Colors.white,
                  filled: true
              ),
            ),
            ),
            ),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 14),
            child: Flexible(child: SizedBox(width: 400, child: TextField(
              controller: tecEdad,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escribe tu edad',
                  fillColor: Colors.white,
                  filled: true
              ),
            ),
            ),
            ),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 14),
            child: Flexible(child: SizedBox(width: 400, child: TextField(
              controller: tecPeso,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escribe tu peso',
                  fillColor: Colors.white,
                  filled: true
              ),
            ),
            ),
            ),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 14),
            child: Flexible(child: SizedBox(width: 400, child: TextField(
              controller: tecColorOjos,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escribe tu color de ojos',
                  fillColor: Colors.white,
                  filled: true
              ),
            ),
            ),
            ),
          ),

          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: onClickAceptar, style: TextButton.styleFrom(foregroundColor: Colors.black), child: Text("Aceptar"),),
              TextButton(onPressed: onClickCancelar, style: TextButton.styleFrom(foregroundColor: Colors.black), child: Text("Cancelar"),)
            ],)
        ], // children
      ),
    );
  }
}