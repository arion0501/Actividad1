import 'package:flutter/material.dart';
import 'SingleTone/DataHolder.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Actividad1.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DataHolder().initDataHolder();
  runApp(Actividad1());
}

void initFB() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
