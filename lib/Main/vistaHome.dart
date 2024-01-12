import 'package:actividad1/Custom/VistaGridCelda.dart';
import 'package:actividad1/Custom/VistaLista.dart';
import 'package:actividad1/ObjetosFirestore/PublicacionesFS.dart';
import 'package:actividad1/OnBoarding/vistaLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../Custom/DrawerCustom.dart';
import '../Custom/MenuBotones.dart';
import '../SingleTone/DataHolder.dart';

class vistaHome extends StatefulWidget {
  @override
  State<vistaHome> createState() => _vistaHomeState();
}

class _vistaHomeState extends State<vistaHome> {
  FirebaseFirestore fb = FirebaseFirestore.instance;
  final List<PublicacionesFS> publicaciones = [];
  bool bIsList = false;

  @override
  void initState() {
    super.initState();
    descargarPublicaciones();
  }

  Future<void> fHomeViewDrawerOntap(int indice) async {
    if (indice == 0) {
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => vistaLogin()),
        ModalRoute.withName('/vistalogin'),
      );
    } else if (indice == 1) {
      List<String> usersInRange = await DataHolder().geolocAdmin.obtenerUsuariosEnRango();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Usuarios en rango de 5 km:'),
            content: Column(
              children: usersInRange
                  .map(
                    (userId) => Text(
                  userId ?? 'Usuario sin ID',
                  // 'Usuario sin ID' se mostrará si userId es nulo
                ),
              )
                  .toList(),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void onBottonMenuPressed(int indice) {
    setState(() {
      if (indice == 0) {
        bIsList = true;
      } else if (indice == 1) {
        bIsList = false;
      }
    });
  }

  void descargarPublicaciones() async {
    CollectionReference<PublicacionesFS> collection = fb
        .collection("Publicaciones")
        .withConverter(
            fromFirestore: PublicacionesFS.fromFirestore,
            toFirestore: (PublicacionesFS publicacionesFS, _) =>
                publicacionesFS.toFirestore());

    QuerySnapshot<PublicacionesFS> querySnapshot = await collection.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      setState(() {
        publicaciones.add(querySnapshot.docs[i].data());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Actividad1"),
        actions: [
          PopupMenuButton(
            onSelected: (indice) {
              switch (indice) {
                case 'apiTiempo':
                  apiTiempo();
                  break;
                case 'apiUbicacion':
                  apiUbicacion();
                  break;
                case 'buscaTitulo':
                  buscarPorTitulo();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'apiTiempo',
                child: ListTile(
                  leading: Icon(Icons.sunny_snowing),
                  title: Text('Temperatura'),
                ),
              ),
              PopupMenuItem(
                value: 'apiUbicacion',
                child: ListTile(
                  leading: Icon(Icons.map_rounded),
                  title: Text('Ubicación'),
                ),
              ),
              PopupMenuItem(
                value: 'buscaTitulo',
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: Text('Buscar por título'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: listaOCelda(bIsList),
      ),
      bottomNavigationBar: MenuBotones(evento: onBottonMenuPressed),
      drawer: DrawerCustom(onItemTap: fHomeViewDrawerOntap),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/vistacreapublicacion");
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }

  Future<void> apiTiempo() async {
    try {
      Position currentPosition = await DataHolder().geolocAdmin.determinePosition();

      double temperatura = await DataHolder().admin.pedirTemperaturasEn(
          currentPosition.latitude, currentPosition.longitude);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Información'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('La temperatura actual es de: $temperatura'),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error al obtener la temperatura'),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void apiUbicacion() async {
    try {
      Map<String, dynamic> ubicacionCliente = await DataHolder().admin.obtenerUbicacionCliente();

      String ip = ubicacionCliente['ip'];
      String ciudad = ubicacionCliente['city'];
      String region = ubicacionCliente['region'];
      String pais = ubicacionCliente['country'];
      String codigoPostal = ubicacionCliente['postal'];
      double latitud = double.parse(ubicacionCliente['loc']?.split(',')[0] ?? '0');
      double longitud = double.parse(ubicacionCliente['loc']?.split(',')[1] ?? '0');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Información de Ubicación del Cliente'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('IP: $ip'),
                Text('Ciudad: $ciudad'),
                Text('Región: $region'),
                Text('País: $pais'),
                Text('Código Postal: $codigoPostal'),
                Text('Latitud: $latitud'),
                Text('Longitud: $longitud'),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error al obtener la ubicación del cliente'),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void buscarPorTitulo() {
    TextEditingController _searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Buscar Post por Título'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Ingrese el título a buscar',
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  String searchValue = _searchController.text.trim();
                  if (searchValue.isNotEmpty) {
                    Navigator.of(context).pop(); // Cerrar el diálogo de búsqueda
                    buscarTituloAsync(searchValue);
                  }
                },
                child: Text('Buscar'),
              ),
            ],
          ),
        );
      },
    );
  }

  void buscarTituloAsync(String searchValue) async {
    List<String> matches = [];

    for (var post in publicaciones) {
      if (post.titulo.toLowerCase().startsWith(searchValue.toLowerCase())) {
        matches.add(post.titulo);
      }
    }

    if (matches.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Resultados de la Búsqueda'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Se encontraron posts con el título que comienza con: $searchValue'),
                for (var match in matches)
                  Text('• $match'),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Resultados de la Búsqueda'),
            content: Text(
                'No se encontraron posts con el título que comience con: $searchValue'),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }


  Widget? listaOCelda(bool isList) {
    if (isList) {
      return ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: publicaciones.length,
        itemBuilder: creadorDeListaPublicacion,
        separatorBuilder: separadorLista,
      );
    } else {
      return creadorDeCeldaPublicacion(context, publicaciones.length);
    }
  }

  void onItemListaClicked(int index) {
    DataHolder().selectedPost = publicaciones[index];
    DataHolder().saveSelectedPostInCache();
    Navigator.of(context).pushNamed('/vistapublicacion');
  }

  Widget? creadorDeListaPublicacion(BuildContext context, int index) {
    return vistaLista(
      sTexto: publicaciones[index].titulo,
      dTamanyoFuente: 30,
      iCodigoColor: Colors.pink,
      onItemListClickedFun: onItemListaClicked,
      iPosicion: index,
    );
  }

  Widget? creadorDeCeldaPublicacion(BuildContext context, int index) {
    return vistaGridCelda(
        publicaciones: publicaciones, onItemListClickedFun: onItemListaClicked);
  }

  Widget separadorLista(BuildContext context, int index) {
    return Divider();
  }
}
