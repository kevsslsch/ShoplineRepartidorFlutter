class user {
  int id;
  String uuid;
  String nombre;
  String email;
  String casillero;
  int meses;

  String sexo;
  int sucursal;
  int tarifa;
  String nombre_sucursal;
  String nombre_tarifa;
  String telefono_contacto;
  String telefono_opcional;
  String direccion;

  String message;
  bool status;

  user({required this.id,
    required this.uuid,
    required this.nombre,
    required this.email,
    required this.casillero,
    required this.meses,

    required this.sexo,
    required this.sucursal,
    required this.tarifa,
    required this.nombre_sucursal,
    required this.nombre_tarifa,
    required this.telefono_contacto,
    required this.telefono_opcional,
    required this.direccion,

    required this.message,
    required this.status});

  factory user.fromJson(Map<String, dynamic> json) {
    return user(
        id: (json['id'] == null ? 0 : json['id']),
        uuid: (json['uuid'] == null ? "" : json['uuid']),
        nombre: (json['nombre'] == null ? "" : json['nombre']),
        email: (json['email'] == null ? "" : json['email']),
        casillero: (json['casillero'] == null ? "" : json['casillero']),
        meses: (json['meses'] == null ? 0 : json['meses']),

        sexo: (json['sexo'] == null ? "" : json['sexo']),
        sucursal: (json['sucursal'] == null ? 0 : json['sucursal']),
        tarifa: (json['tarifa'] == null ? 0 : json['tarifa']),
        nombre_sucursal: (json['nombre_sucursal'] == null ? "" : json['nombre_sucursal']),
        nombre_tarifa: (json['nombre_tarifa'] == null ? "" : json['nombre_tarifa']),
        telefono_contacto: (json['telefono_contacto'] == null ? "" : json['telefono_contacto']),
        telefono_opcional: (json['telefono_opcional'] == null ? "" : json['telefono_opcional']),
        direccion: (json['direccion'] == null ? "" : json['direccion']),

        message: json['message'] as String,
        status: json['status'] as bool);
  }
}
