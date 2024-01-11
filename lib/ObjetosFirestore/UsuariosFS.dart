import 'package:cloud_firestore/cloud_firestore.dart';

class UsuariosFS {

  final String nombre;
  final int edad;
  final double peso;
  final String colorOjos;
  GeoPoint geoloc;

  UsuariosFS({
    required this.nombre,
    required this.edad,
    required this.peso,
    required this.colorOjos,
    required this.geoloc
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
        colorOjos: data?['colorOjos'] != null ? data!['colorOjos'] : "",
        geoloc: data?['geoloc'] != null ? data!['geoloc'] : const GeoPoint(0, 0)
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "nombre": nombre,
      "edad": edad,
      "peso": peso,
      "colorOjos": colorOjos,
      "geoloc": geoloc,
    };
  }
}