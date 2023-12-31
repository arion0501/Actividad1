import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Custom/A1TextField.dart';

class vistaLoginMovil extends StatefulWidget {
  @override
  State<vistaLoginMovil> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<vistaLoginMovil> {

  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecVerify = TextEditingController();
  String sVerificationCode = "";
  bool blMostrarVerification = false;

  void enviarTelefonoPressed() async{
    String sTelefono = tecPhone.text;

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: sTelefono,
      verificationCompleted: verificacionCompletada,
      verificationFailed: verificacionFallida,
      codeSent: codigoEnviado,
      codeAutoRetrievalTimeout: tiempoDeEsperaAcabado,
    );
  }

  void enviarVerifyPressed() async{
    String smsCode = tecVerify.text;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(verificationId: sVerificationCode, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.of(context).popAndPushNamed('/vistahome');
  }

  void verificacionCompletada(PhoneAuthCredential credencial) async{
    await FirebaseAuth.instance.signInWithCredential(credencial);

    Navigator.of(context).popAndPushNamed('/vistahome');
  }

  void verificacionFallida(FirebaseAuthException excepcion) {
    if (excepcion.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  }

  void codigoEnviado(String codigo, int? resendToken) async{
    sVerificationCode = codigo;
    setState(() {
      blMostrarVerification = true;
    });
  }

  void tiempoDeEsperaAcabado(String tiempoCodigo) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          A1TextField(labelText: 'Número de teléfono', tecController: tecPhone),
          TextButton(onPressed: enviarTelefonoPressed, child: Text('Enviar')),
          if(blMostrarVerification)
            A1TextField(labelText: 'Número de verificación', tecController: tecVerify),
          if(blMostrarVerification)
            TextButton(onPressed: enviarVerifyPressed, child: Text('Enviar')),
        ],
      ),
    );
  }
}