import 'package:actividad1/ObjetosFirestore/PublicacionesFS.dart';
import 'package:flutter/material.dart';
import '../SingleTone/DataHolder.dart';

class vistaPublicacion extends StatefulWidget {

  @override
  State<vistaPublicacion> createState() => _PostViewState();
}
class _PostViewState extends State<vistaPublicacion> {
  late PublicacionesFS selectedPost;

  @override
  void initState() async{
    super.initState();
    setState(() async {
      selectedPost = await DataHolder().initCachedFbPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          Text(DataHolder().selectedPost.titulo),
          Text(DataHolder().selectedPost.cuerpo),
          Image.asset("Recursos/aiGenerated.png", width: 70),
          TextButton(onPressed: null, child: Text("Like"))
        ],
      ),
    );
  }
}