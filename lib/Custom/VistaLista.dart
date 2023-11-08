import 'package:flutter/material.dart';

class vistaLista extends StatelessWidget{

  final String sTexto;
  final int iCodigoColor;
  final double dTamanyoFuente;

  const vistaLista ({
    required this.sTexto,
    required this.iCodigoColor,
    required this.dTamanyoFuente});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.amber[iCodigoColor],
        child: Row(
          children: [
            Image.asset('Recursos/aiGenerated.png',
                width: 30,
                height: 45),
            Text(sTexto)
          ],
        )
    );
  }
}