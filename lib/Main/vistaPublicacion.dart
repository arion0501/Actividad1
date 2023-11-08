import 'package:flutter/material.dart';
import '../SingleTone/DataHolder.dart';

class vistaPublicacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          Text(DataHolder().selectedPost.titulo),
          Text(DataHolder().selectedPost.cuerpo),
          Image.network("imagen"),
          TextButton(onPressed: null, child: Text("Like"))
        ],
      ),
    );
  }
}