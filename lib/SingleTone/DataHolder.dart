import 'package:actividad1/ObjetosFirestore/PublicacionesFS.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataHolder {

  static final DataHolder _dataHolder = new DataHolder._internal();
  FirebaseFirestore fs = FirebaseFirestore.instance;

  String sNombre = "Actividad 1 DataHolder";
  late String sPostTitulo;
  late PublicacionesFS selectedPost;

  DataHolder._internal() {
    sPostTitulo = "Titulo del Post";
  }

  factory DataHolder(){
    return _dataHolder;
  }

  void crearPublicacionEnFB(PublicacionesFS post) {
    CollectionReference<PublicacionesFS> postRef = fs
        .collection("Publicaciones")
        .withConverter(fromFirestore: PublicacionesFS.fromFirestore,
        toFirestore: (PublicacionesFS post,_) => post.toFirestore());

    postRef.add(post);
  }

  void initCachedFbPublicacion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? fbpost_titulo = prefs.getString('fbpost_titulo');
    fbpost_titulo ??= "";

    String? fbpost_cuerpo = prefs.getString('fbpost_cuerpo');
    if(fbpost_cuerpo == null) {
      fbpost_cuerpo = "";
    }
    selectedPost = PublicacionesFS(titulo: fbpost_titulo, cuerpo: fbpost_cuerpo);
  }

}