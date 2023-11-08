import 'package:flutter/material.dart';

class vistaLista extends StatelessWidget{

  final String sTexto;
  final MaterialColor iCodigoColor;
  final double dTamanyoFuente;
  final int iPosicion;
  final Function(int indice)? onItemListClickedFun;


  const vistaLista ({
    required this.sTexto,
    required this.iCodigoColor,
    required this.dTamanyoFuente,
    required this.iPosicion,
    required this.onItemListClickedFun});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          color: iCodigoColor,
          child: Row(
            children: [
              Image.asset('Recursos/aiGenerated.png',
                  width: 55,
                  height: 55),
              Text(sTexto,style: TextStyle(fontSize: dTamanyoFuente)),
              TextButton(onPressed: null, child: Text(" +",style: TextStyle(fontSize: dTamanyoFuente)))
            ],
          )
      ),
      onTap: () {
        onItemListClickedFun!(iPosicion);
      },
    );
  }
}