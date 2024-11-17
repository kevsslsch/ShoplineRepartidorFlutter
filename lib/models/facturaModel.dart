class factura {
  final int id;
  final double totalFactura;
  final String comentarios;
  final String codigo;

  factura(
      {required this.id,
      required this.totalFactura,
      required this.comentarios,
      required this.codigo});

  factory factura.fromJson(Map<String, dynamic> json) {
    return factura(
        id: json['id'],
        totalFactura: json['total_factura'].toDouble(),
        comentarios: json['comentarios'],
        codigo: json['codigo']);
  }
}
