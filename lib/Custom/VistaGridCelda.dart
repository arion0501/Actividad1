import 'package:actividad1/ObjetosFirestore/PublicacionesFS.dart';
import 'package:flutter/material.dart';

class vistaGridCelda extends StatelessWidget{

  final List<PublicacionesFS> publicaciones;
  final Function(int indice)? onItemListClickedFun;

  const vistaGridCelda({super.key,
    required this.publicaciones,
    required this.onItemListClickedFun
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        padding: EdgeInsets.all(8),
        itemCount: publicaciones.length,
        itemBuilder: (context, index) {

          return InkWell(
            child: Container(
              color: Colors.indigoAccent,
              child: Center(
                child: Text(
                  publicaciones[index].titulo,
                  style: TextStyle(fontSize: 20, color: Colors.orange),
                ),
              ),
            ),
            onTap: () {
              onItemListClickedFun!(index);
            },
          );
        }
    );
  }
}