import 'package:actividad1/ObjetosFirestore/PublicacionesFS.dart';
import 'package:flutter/material.dart';
import '../SingleTone/DataHolder.dart';

class vistaPublicacion extends StatefulWidget {

  @override
  State<vistaPublicacion> createState() => _PostViewState();
}
class _PostViewState extends State<vistaPublicacion> {
  PublicacionesFS _datosPublicacion = PublicacionesFS(titulo: "titulo", cuerpo: "cuerpo");


  @override
  void initState() {
    super.initState();
    cargarPostGuardadoEnCache();
  }

  void cargarPostGuardadoEnCache() async {
    var temp1 = await DataHolder().initCachedFbPost();

    setState(() {
      _datosPublicacion = temp1!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          Text(_datosPublicacion.titulo),
          Text(_datosPublicacion.cuerpo),
          Image.asset("Recursos/aiGenerated.png", width: 70, height: 70),
          TextButton(onPressed: null, child: Text("Like"))
        ],
      ),
    );
  }
}