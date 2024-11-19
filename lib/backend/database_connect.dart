import 'dart:convert';
import 'package:becadosCE/models/responseModel.dart';
import 'package:becadosCE/models/rutaModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/userModel.dart';
import '../models/versionModel.dart';

class DatabaseProvider {
  late SharedPreferences preffs;
  static const VERSION = "1.0.0";

  static const ROOT = "https://shoplinepanama.com/apis_repartidor/";
  static const ROOTLOGIN = ROOT + "api.login.php";
  static const ROOTVERSION = ROOT + "api.get_version.php";
  static const ROOTGETRUTA = ROOT + "api.get_ruta.php";
  static const ROOTPROBLEMAENTREGA = ROOT + "api.solicitud_problema_entrega.php";
  static const ROOTENTREGADASOLICITUD = ROOT + "api.solicitud_entregada.php";

  static Future<user> login(String userValue, String password) async {
    Map data = {'user': userValue, 'password': password};

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(ROOTLOGIN),
        headers: {"Content-Type": "application/json"}, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      print("response" + response.body);
      user list = user.fromJson(json.decode(response.body));

      return list;
    } else {
      throw <user>[];
    }
  }

  static Future<version> getVersion() async {
    //encode Map to JSON
    var response = await http.get(Uri.parse(ROOTVERSION) );
    if (response.statusCode == 200) {
      version resultado = version.fromJson(json.decode(response.body));

      return resultado;
    } else {
      throw <version>[];
    }
  }

  static Future<ruta> getRuta(String uuid) async {

    Map data = {
      'uuid': uuid
    };

    var body = json.encode(data);
    var response = await http.post(
        Uri.parse(ROOTGETRUTA),
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if (response.statusCode == 200) {
      print(response.body);
      var jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == true) {
        // Solo hay una ruta, por lo que no necesitamos convertirla en una lista
        ruta rutaData = ruta.fromJson(jsonResponse['ruta']);
        return rutaData;
      } else {
        throw Exception('Error: ${jsonResponse['message']}');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<responseModel> problameEntregaSolicitud(String uuid, int id_solicitud_ruta) async {
    Map data = {'uuid': uuid, 'id_solicitud_ruta': id_solicitud_ruta};

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(ROOTPROBLEMAENTREGA),
        headers: {"Content-Type": "application/json"}, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      print("response" + response.body);
      responseModel responseApi = responseModel.fromJson(json.decode(response.body));

      return responseApi;
    } else {
      throw <user>[];
    }
  }

  static Future<responseModel> entregadaSolicitud(String uuid, int id_solicitud_ruta) async {
    Map data = {'uuid': uuid, 'id_solicitud_ruta': id_solicitud_ruta};

    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(ROOTENTREGADASOLICITUD),
        headers: {"Content-Type": "application/json"}, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      print("response" + response.body);
      responseModel responseApi = responseModel.fromJson(json.decode(response.body));

      return responseApi;
    } else {
      throw <user>[];
    }
  }


}
