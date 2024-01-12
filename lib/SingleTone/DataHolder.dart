import 'package:actividad1/ObjetosFirestore/PublicacionesFS.dart';
import 'package:actividad1/ObjetosFirestore/UsuariosFS.dart';
import 'package:actividad1/SingleTone/Admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FirebaseAdmin.dart';
import 'GeolocAdmin.dart';
import 'PlatformAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = new DataHolder._internal();
  FirebaseFirestore fs = FirebaseFirestore.instance;
  GeolocAdmin geolocAdmin = GeolocAdmin();
  Admin admin = Admin();
  FirebaseAdmin fbAdmin = FirebaseAdmin();
  UsuariosFS? usuario;

  String sNombre = "Actividad 1 DataHolder";
  late String sPostTitulo;
  late PublicacionesFS selectedPost;
  late PlatformAdmin platformAdmin;

  DataHolder._internal() {
    platformAdmin = PlatformAdmin();
    initCachedFbPost();
  }

  void initDataHolder() {
    /*sPostTitulo = "Titulo del Post";
    initCachedFbPost();*/
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
    if(selectedPost != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('titulo', selectedPost.titulo);
      prefs.setString('cuerpo', selectedPost.cuerpo);
    }
  }

  Future<PublicacionesFS> initCachedFbPost() async {
    if(selectedPost != null) return selectedPost;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? fbpost_titulo = prefs.getString('titulo');
    fbpost_titulo ??= "";

    String? fbpost_cuerpo = prefs.getString('cuerpo');
    fbpost_cuerpo ??= "";

    print("Shared preferences --> " + fbpost_titulo);
    selectedPost = PublicacionesFS(titulo: fbpost_titulo, cuerpo: fbpost_cuerpo);

    return selectedPost;
  }

  void suscribeACambiosGPSUsuario () {
    geolocAdmin.registrarCambiosLoc(posicionDelMovilCambio);
  }

  void posicionDelMovilCambio(Position? position) {
    usuario!.geoloc = GeoPoint(position!.latitude, position.longitude);
    fbAdmin.actualizarPerfilUsuario(usuario!);
  }
}