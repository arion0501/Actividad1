import 'package:actividad1/Custom/A1TextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class vistaLogin extends StatelessWidget {

  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  void onClickAccept() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tecUsername.text,
          password: tecPassword.text
      );

      Navigator.of(_context).popAndPushNamed('/vistahome');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void onClickRegister() {
    Navigator.of(_context).popAndPushNamed('/vistaregistro');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    Column columna = Column(children: [
      // Separación Tabla
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Text('ACTIVIDAD 1', style: TextStyle(fontSize: 20, fontFamily: 'Lobster')),

      A1TextField(
        tecController: tecUsername,
        labelText: 'Input Username ACTIVIDAD1',
      ),


      A1TextField(
        tecController: tecPassword,
        labelText: 'Input Password ACTIVIDAD1',
        isPassword: true,
      ),



      Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(onPressed: onClickAccept, style: TextButton.styleFrom(foregroundColor: Colors.black), child: Text('Accept')),
          TextButton(onPressed: onClickRegister, style: TextButton.styleFrom(foregroundColor: Colors.black), child: Text('Register'))
        ],)
    ],
        mainAxisAlignment: MainAxisAlignment.center
    );

    AppBar appBar = AppBar(
      title: Text('LOGIN', style: TextStyle(fontSize: 24, fontFamily: 'DelaGothicOne')),
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