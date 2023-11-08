import 'package:actividad1/ObjetosFirestore/PublicacionesFS.dart';

class DataHolder {

  static final DataHolder _dataHolder = new DataHolder._internal();

  String sNombre = "Kyty DataHolder";
  late String sPostTitulo;
  late PublicacionesFS selectedPost;

  DataHolder._internal() {
    sPostTitulo = "Titulo del Post";
  }

  factory DataHolder(){
    return _dataHolder;
  }
}