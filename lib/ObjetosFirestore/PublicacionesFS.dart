import 'package:cloud_firestore/cloud_firestore.dart';

class PublicacionesFS {

  final String titulo;
  final String cuerpo;

  PublicacionesFS({
    required this.titulo,
    required this.cuerpo
  });

  factory PublicacionesFS.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return PublicacionesFS(
      titulo: data?['titulo'],
      cuerpo: data?['cuerpo'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (titulo != null) "titulo": titulo,
      if (cuerpo != null) "cuerpo": cuerpo
    };
  }
}