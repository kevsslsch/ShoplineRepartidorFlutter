import 'package:becadosCE/models/facturaModel.dart';

class solicitud {
  final int id_solicitud_ruta;
  final int idSolicitud;
  final String estadoActual;
  final String tipoMetodoPago;
  final double total;
  final String nombreCliente;
  final String telefonoContacto;
  final String direccion;
  final double latitud;
  final double longitud;
  final String horarioPreferencia;
  final String telefonoAlternativo;
  final String referencia;
  final String barriada;
  final List<factura> facturas;

  solicitud({
    required this.id_solicitud_ruta,
    required this.idSolicitud,
    required this.estadoActual,
    required this.tipoMetodoPago,
    required this.total,
    required this.nombreCliente,
    required this.telefonoContacto,
    required this.direccion,
    required this.latitud,
    required this.longitud,
    required this.horarioPreferencia,
    required this.telefonoAlternativo,
    required this.referencia,
    required this.barriada,
    required this.facturas,
  });

  factory solicitud.fromJson(Map<String, dynamic> json) {
    var list = json['facturas'] as List;
    List<factura> invoicesList = list.map((i) => factura.fromJson(i)).toList();

    return solicitud(
      id_solicitud_ruta: json['id_solicitud_ruta'],
      idSolicitud: json['solicitud'],
      estadoActual: json['estado_actual'],
      tipoMetodoPago: json['tipo_metodo_pago'],
      total: json['total'].toDouble(),
      nombreCliente: json['nombre_cliente'],
      telefonoContacto: json['telefono_contacto'],
      direccion: json['direccion'],
      latitud: json['latitud'].toDouble(),
      longitud: json['longitud'].toDouble(),
      horarioPreferencia: json['horario_preferencia'],
      telefonoAlternativo: json['telefono_alternativo'],
      referencia: json['referencia'],
      barriada: json['barriada'],
      facturas: invoicesList,
    );
  }
}
