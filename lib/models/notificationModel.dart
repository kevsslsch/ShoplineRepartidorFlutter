class notification {
  int id;
  String titulo;
  String mensaje;
  String fecha_enviada;
  String tipo_accion;
  String url_accion;
  String html;
  bool vista;

  notification({
    required this.id,
    required this.titulo,
    required this.mensaje,
    required this.fecha_enviada,
    required this.tipo_accion,
    required this.url_accion,
    required this.html,
    required this.vista,
  });

  factory notification.fromJson(Map<String, dynamic> json) {
    return notification(
        id: (json['id'] == null ? 0 : json['id']),
        titulo: (json['titulo'] == null ? "" : json['titulo']),
        mensaje: (json['fecha_enviada'] == null ? "" : json['mensaje']),
        fecha_enviada:
            (json['fecha_enviada'] == null ? "" : json['fecha_enviada']),
        tipo_accion: (json['tipo_accion'] == null ? "" : json['tipo_accion']),
        url_accion: (json['url_accion'] == null ? "" : json['url_accion']),
        html: (json['html'] == null ? "" : json['html']),
        vista: (json['vista'] == null ? false : (json['vista'] == 1)));
  }
}
