import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Admin {
  Admin();

  Future<double> pedirTemperaturasEn(double lat, double lon) async {
    var url = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': lat.toString(),
      'longitude': lon.toString(),
      'hourly': 'temperature_2m',
    });

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      //print("MAPA ENTERO: " + jsonResponse.toString());

      var jsonHourly = jsonResponse['hourly'];
      var jsonTimes = jsonHourly['time'];
      var jsonTiempoActual = jsonTimes[0];
      var jsonTemperaturas = jsonHourly['temperature_2m'];
      var jsonTemperaturaActual = jsonTemperaturas[0];

      double temperaturaActual = jsonTemperaturaActual.toDouble();

      return temperaturaActual;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Error al obtener la temperatura');
    }
  }

  Future<Map<String, dynamic>> obtenerUbicacionCliente() async {
    final apiKey = '13114d2ba29e2b';
    final apiUrl = 'https://ipinfo.io/json?token=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Error al obtener información de ubicación.');
    }
  }
}
