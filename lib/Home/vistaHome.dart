import 'package:flutter/material.dart';

class vistaHome extends StatelessWidget {

  late BuildContext _context;

  void onClickVolver(){
    Navigator.of(_context).popAndPushNamed('/vistalogin');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    Column columna = Column(children : [

      Padding(padding: EdgeInsets.symmetric(vertical: 15),
          child: Text('¡Bienvenido al Home!',
            style: TextStyle(fontSize: 22),)
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: onClickVolver, style: TextButton.styleFrom(foregroundColor: Colors.black), child: Text('Volver')),
          ]
      )
    ]
    );



    AppBar appBar = AppBar(
      title: Text('Home'),
      centerTitle: true,
      backgroundColor: Colors.amber,
      foregroundColor: Colors.deepOrange,
    );

    Scaffold scaf = Scaffold(
      body: columna,
      backgroundColor: Colors.lightGreen,
      appBar: appBar,
    );

    return scaf;
  }
}