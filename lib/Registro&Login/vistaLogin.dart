import 'package:flutter/material.dart';

class vistaLogin extends StatelessWidget{

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    Column columna = Column(children: [
      // Separación Tabla
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Text('ACTIVIDAD 1', style: TextStyle(fontSize: 18)),

      Padding(padding: EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 14), child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Input User ACTIVIDAD1',
        ),
      ),
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 14), child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Input Password ACTIVIDAD1',
        ),
      ),
      ),

    ],);

    AppBar appBar = AppBar(
      title: Text('LOGIN'),
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