import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../ObjetosFirestore/UsuariosFS.dart';

class FirebaseAdmin {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  void actualizarPerfilUsuario(UsuariosFS usuario) async {
    // UID del usuario que está logeado
    String uidUser = FirebaseAuth.instance.currentUser!.uid;
    // Crear documento con un ID nuestro
    await db.collection("Usuarios").doc(uidUser).set(usuario.toFirestore());
  }

  Future<List<Map<String, dynamic>>> buscarPorTitulo(String searchValue) async {
    QuerySnapshot querySnapshot = await db
        .collection('Publicaciones')
        .where('Titulo', isGreaterThanOrEqualTo: searchValue)
        .get();

    return querySnapshot.docs
        .where((doc) =>
            (doc['Titulo'] as String).contains(searchValue) ||
            (doc['Usuarios'] as String).contains(searchValue))
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
