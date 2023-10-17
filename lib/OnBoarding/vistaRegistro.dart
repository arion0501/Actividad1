import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Custom/A1TextField.dart';

class vistaRegistro extends StatelessWidget {

  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();
  TextEditingController tecRepassword = TextEditingController();

  void onClickAccept() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: tecUsername.text,
        password: tecPassword.text,
      );

      Navigator.of(_context).popAndPushNamed('/vistalogin');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void onClickCancel() {
    Navigator.of(_context).popAndPushNamed('/vistalogin');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    Column columna = Column(children: [
      // Separación Tabla
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Text('ACTIVIDAD 1', style: TextStyle(fontSize: 20, fontFamily: 'Orbitron')),

      A1TextField(
        tecController: tecUsername,
        labelText: 'Input Username ACTIVIDAD1',
      ),

      A1TextField(
        tecController: tecPassword,
        isPassword: true,
        labelText: 'Input Password ACTIVIDAD1',
      ),


      A1TextField(
        tecController: tecRepassword,
        isPassword: true,
        labelText: 'Input Repassword ACTIVIDAD1',
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(onPressed: onClickAccept, style: TextButton.styleFrom(foregroundColor: Colors.black), child: Text('Accept')),
          TextButton(onPressed: onClickCancel, style: TextButton.styleFrom(foregroundColor: Colors.black), child: Text('Cancel'))
        ],)
    ],
        mainAxisAlignment: MainAxisAlignment.center
    );

    AppBar appBar = AppBar(
      title: Text('REGISTER', style: TextStyle(fontSize: 24, fontFamily: 'DelaGothicOne')),
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