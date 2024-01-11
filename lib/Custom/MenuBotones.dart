import 'package:flutter/material.dart';

class MenuBotones extends StatelessWidget{

  Function (int indice)? evento;

  MenuBotones({Key? key,required this.evento
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => evento!(0), child: Icon(Icons.list,color: Colors.blueAccent)),
          TextButton(onPressed: () => evento!(1), child: Icon(Icons.grid_view,color: Colors.blueAccent)),
          IconButton(onPressed: () => evento!(2), icon: Image.asset("Recursos/aiGenerated.png", width: 30, height: 30))
        ]
    );
  }
}