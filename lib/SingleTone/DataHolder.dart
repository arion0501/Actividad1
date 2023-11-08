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

  }

  void initDataHolder() {
    sPostTitulo = "Titulo del Post";
    initCachedFbPost();
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

  void saveSelectedPostInCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('titulo', selectedPost.titulo);
    prefs.setString('cuerpo', selectedPost.cuerpo);
  }

  Future<PublicacionesFS> initCachedFbPost() async {
    if(selectedPost != null) {
      return selectedPost;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? fbpost_titulo = prefs.getString('titulo');
    fbpost_titulo ??= "";

    String? fbpost_cuerpo = prefs.getString('cuerpo');
    fbpost_cuerpo ??= "";

    print("Shared preferences --> " + fbpost_titulo);
    selectedPost = PublicacionesFS(titulo: fbpost_titulo, cuerpo: fbpost_cuerpo);

    return selectedPost;
  }
}