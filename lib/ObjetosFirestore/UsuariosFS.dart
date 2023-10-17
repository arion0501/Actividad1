import 'package:cloud_firestore/cloud_firestore.dart';

class UsuariosFS {

  final String nombre;
  final int edad;
  final double peso;
  final String colorOjos;

  UsuariosFS({
    required this.nombre,
    required this.edad,
    required this.peso,
    required this.colorOjos
  });

  factory UsuariosFS.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UsuariosFS(
        nombre: data?['nombre'],
        edad: data?['edad'] != null ? data!['edad'] : 0,
        peso: data?['peso'] != null ? data!['peso'] : 0,
        colorOjos: data?['colorOjos'] != null ? data!['colorOjos'] : ""
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "nombre": nombre,
      if (edad != null) "edad": edad,
      if (peso != null) "peso": peso,
      if (colorOjos != null) "colorOjos": colorOjos,
    };
  }
}