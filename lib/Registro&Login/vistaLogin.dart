import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class vistaLogin extends StatelessWidget{

  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  void onClickAccept() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tecUsername.text,
          password: tecPassword.text
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void onClickRegister() {
    Navigator.of(_context).popAndPushNamed('/vistaregistrar');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    Column columna = Column(children: [
      // Separación Tabla
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Text('ACTIVIDAD 1', style: TextStyle(fontSize: 18)),

      Padding(padding: EdgeInsets.symmetric(
          horizontal: Checkbox.width, vertical: 14), child: TextField(
        controller: tecUsername,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Input Username ACTIVIDAD1',
        ),
      ),
      ),

      Padding(padding: EdgeInsets.symmetric(
          horizontal: Checkbox.width, vertical: 14), child: TextField(
        controller: tecPassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Input Password ACTIVIDAD1',
        ),
      ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: onClickAccept, child: Text('Accept')),
          TextButton(onPressed: onClickRegister, child: Text('Register'))
        ],)

    ],);

    AppBar appBar = AppBar(
      title: Text('LOGIN'),
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