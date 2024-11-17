import 'package:becadosCE/models/solicitudModel.dart';

class ruta {
  final int idRuta;
  final String estadoActual;
  final String comentarios;
  final List<solicitud> solicitudes;

  ruta({
    required this.idRuta,
    required this.estadoActual,
    required this.comentarios,
    required this.solicitudes
  });

  factory ruta.fromJson(Map<String, dynamic> json) {
    var list = json['solicitudes'] as List;
    List<solicitud> solicitudesList = list.map((i) => solicitud.fromJson(i)).toList();

    return ruta(
        idRuta: json['id_ruta'],
        estadoActual: json['estado_actual'],
        comentarios: json['comentarios'],
        solicitudes: solicitudesList
    );
  }
}