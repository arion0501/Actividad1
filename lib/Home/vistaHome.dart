import 'package:flutter/material.dart';

class vistaHome extends StatelessWidget {

  late BuildContext _context;

  void onClickVolver(){
    Navigator.of(_context).popAndPushNamed('/vistalogin');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    Column columna = Column(

    );

    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextButton(onPressed: onClickVolver, child: Text('Volver')),
    ]
    );

    AppBar appBar = AppBar(
      title: Text('Home'),
      centerTitle: true,
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.black,
    );

    Scaffold scaf = Scaffold(
      body: columna,
      backgroundColor: Colors.lightGreen,
      appBar: appBar,
    );

    return scaf;
  }
}