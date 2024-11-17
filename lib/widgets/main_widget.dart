import 'package:becadosCE/models/rutaModel.dart';
import 'package:becadosCE/models/solicitudModel.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../application/functions.dart';
import '../backend/database_connect.dart';
import '../components/shimmers.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../models/facturaModel.dart';
import '../models/userModel.dart';

class MainWidget extends StatefulWidget {
  final user usuario;

  const MainWidget({Key? key, required this.usuario}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  late SharedPreferences preffs;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loadingRuta = false;

  late ruta rutaData;
  List<solicitud> listSolicitudes = [];

  @override
  void initState() {
    super.initState();
    _getRuta();
  }

  _getRuta() {
    DatabaseProvider.getRuta(widget.usuario.uuid).then((value) {
      setState(() {
        rutaData = value;
        listSolicitudes = rutaData.solicitudes;

        loadingRuta = false;
      });
    });
  }

  _markAsDelivered(solicitud solicitudData) {
    // Obtén la información de la solicitud (suponiendo que tienes un objeto 'solicitud' con la propiedad 'tipoMetodoPago' y 'total')
    var tipoMetodoPago = solicitudData.tipoMetodoPago;
    var total = solicitudData.total;

    // Abrir el BottomSheet
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Marcar como entregada',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Mostrar importe si es en efectivo
              if (tipoMetodoPago == 'Efectivo')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Importe a cobrar: \$${total.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

              // Mensaje de deslizar para confirmar
              Text(
                'Desliza para marcar como entregada',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // SwipeButton para confirmar la entrega
              SwipeButton.expand(
                duration: const Duration(milliseconds: 200),
                thumb: const Icon(
                  Icons.double_arrow_rounded,
                  color: Colors.white,
                ),
                activeThumbColor: FlutterFlowTheme.of(context).primaryColor,
                activeTrackColor: Colors.grey.shade300,
                onSwipe: () {
                  Navigator.pop(context); // Cerrar el BottomSheet
                  _marcarEntregada(solicitudData.id_solicitud_ruta); // Marcar la solicitud como entregada
                },
                child: const Text(
                  "Desliza para confirmar ...",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<bool?> _showConfirmationDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("¿Estás seguro?"),
          content: Text("¿Deseas marcar esta solicitud como un problema de entrega?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // El usuario cancela
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // El usuario confirma
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  _marcarProblemaEntrega(int solicitudId) async {
    bool? confirm = await _showConfirmationDialog();

    if (confirm != null && confirm) {
      // Llamar a la API si el usuario confirma
      DatabaseProvider.problameEntregaSolicitud(widget.usuario.uuid, solicitudId).then((value) {
        setState(() {
         if(value.status){
           _getRuta();
         }else{
           Functions.showAlert(context, "Error al marcar como problema de entrega " + value.message);
         }
        });
      });
    }
  }

  _marcarEntregada(int solicitudId) async {
    DatabaseProvider.entregadaSolicitud(widget.usuario.uuid, solicitudId).then((value) {
      setState(() {
        if(value.status){
          _getRuta();
        }else{
          Functions.showAlert(context, "Error al marcar como entregada " + value.message);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).background,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsetsDirectional.all(20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15, 10, 15, 15),
                          child: Row(
                            children: [
                              Text("Facturas pendientes",
                                  style: GoogleFonts.getFont('Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Container(
                              width: double.infinity,
                              child: Card(
                                color: Colors.white,
                                margin: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 15,
                                shadowColor: Color(0x56EEEEEE),
                                // Color de sombra más gris
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    loadingRuta
                                        ? ShimmerInvoices()
                                        : listSolicitudes.isEmpty
                                            ? Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(20, 20, 20, 20),
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/empty.jpg',
                                                        width:
                                                            200, // Ancho deseado
                                                        height:
                                                            200, // Alto deseado
                                                      ),
                                                      Text(
                                                        'No se encontraron solicitudes pendientes.',
                                                        style:
                                                            GoogleFonts.getFont(
                                                                'Poppins',
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            : Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: listSolicitudes
                                                          .length,
                                                      shrinkWrap: true,
                                                      itemBuilder: (context,
                                                          listViewIndex) {
                                                        final solicitud =
                                                            listSolicitudes[
                                                                listViewIndex];

                                                        Color _color, _color2;

                                                        // Determinar el estado actual de la solicitud
                                                        if (solicitud
                                                                .estadoActual ==
                                                            'En Ruta') {
                                                          _color = Color(
                                                              0xFFFDEACC); // Color de fondo
                                                          _color2 = Color(
                                                              0xFFFFAB00); // Color de texto
                                                        } else if (solicitud
                                                                .estadoActual ==
                                                            'Problema de Entrega') {
                                                          _color = Color(0xFFFFCDD2); // Color de fondo suave para mostrar alerta de problema de entrega
                                                          _color2 = Color(0xFFD32F2F); // Color de estado (rojo) para mostrar "Problema de entrega"
                                                        } else if (solicitud
                                                                .estadoActual ==
                                                            'Entregada') {
                                                          _color = Color(
                                                              0xFFF1FFE7); // Color de fondo
                                                          _color2 = Color(
                                                              0xFF71DD37); // Color de texto
                                                        } else {
                                                          _color = Color(
                                                              0xFFCCF5FF); // Color de fondo
                                                          _color2 = Color(
                                                              0xFF03C3EC); // Color de texto
                                                        }

                                                        return Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                                                              child: Card(
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                ),
                                                                color: _color,
                                                                elevation: 0.0,
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(16.0),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          // Row con los tres botones en la parte superior derecha
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              // Estado de la solicitud
                                                                              Container(
                                                                                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                                                                decoration: BoxDecoration(
                                                                                  color: _color2,
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                ),
                                                                                child: Text(
                                                                                  "${solicitud.estadoActual}",
                                                                                  style: GoogleFonts.poppins(
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              // Tres botones a la derecha (dejo los íconos originales)
                                                                              Row(
                                                                                children: [
                                                                                  IconButton(
                                                                                    icon: Icon(Icons.remove_red_eye, color: Colors.black),
                                                                                    onPressed: () => _showFacturasBottomSheet(context, solicitud.facturas),
                                                                                  ),

                                                                                  Visibility(
                                                                                    visible: solicitud.estadoActual == 'En Ruta',
                                                                                    child: Row(
                                                                                      children: [
                                                                                        IconButton(
                                                                                          icon: Icon(Icons.check_circle, color: Colors.green),
                                                                                          onPressed: () => _markAsDelivered(solicitud),
                                                                                        ),
                                                                                        IconButton(
                                                                                          icon: Icon(Icons.report_problem, color: Colors.red),
                                                                                          onPressed: () => _marcarProblemaEntrega(solicitud.id_solicitud_ruta),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )

                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 10),
                                                                          // Detalles de la solicitud
                                                                          Text(
                                                                            "Solicitud #${solicitud.id_solicitud_ruta}",
                                                                            style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
                                                                          ),
                                                                          SizedBox(height: 6),
                                                                          Text(
                                                                            "${solicitud.nombreCliente}",
                                                                            style: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
                                                                          ),
                                                                          SizedBox(height: 6),
                                                                          Text(
                                                                            "${solicitud.tipoMetodoPago}",
                                                                            style: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
                                                                          ),
                                                                          SizedBox(height: 6),
                                                                          Text(
                                                                            "Total: \$${solicitud.total.toStringAsFixed(2)}",
                                                                            style: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
                                                                          ),
                                                                          SizedBox(height: 6),
                                                                          // Dirección (el valor es clickeable)
                                                                          Text(
                                                                            "Dirección: ",
                                                                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap: () => _openMapWithCoordinates(solicitud.latitud, solicitud.longitud),
                                                                            child: Text(
                                                                              "${solicitud.direccion}",
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 12,
                                                                                color: Colors.blue, // Color azul como un enlace
                                                                                decoration: TextDecoration.underline, // Subrayado
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: 6),
                                                                          Text(
                                                                            "Referencia: ${solicitud.referencia}",
                                                                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                                                                          ),
                                                                          SizedBox(height: 6),
                                                                          Text(
                                                                            "Barriada: ${solicitud.barriada}",
                                                                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                                                                          ),
                                                                          SizedBox(height: 6),
                                                                          Text(
                                                                            "Horario Preferencia: ${solicitud.horarioPreferencia}",
                                                                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                                                                          ),
                                                                          SizedBox(height: 6),
                                                                          // Teléfono Contacto (el valor es clickeable)
                                                                          Text(
                                                                            "Teléfono Contacto: ",
                                                                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap: () => _makePhoneCall(solicitud.telefonoContacto),
                                                                            child: Text(
                                                                              "${solicitud.telefonoContacto}",
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 12,
                                                                                color: Colors.blue, // Color azul como un enlace
                                                                                decoration: TextDecoration.underline, // Subrayado
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: 6),
                                                                          // Teléfono Alternativo (el valor es clickeable)
                                                                          Text(
                                                                            "Teléfono Alternativo: ",
                                                                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap: () => _makePhoneCall(solicitud.telefonoAlternativo),
                                                                            child: Text(
                                                                              "${solicitud.telefonoAlternativo}",
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 12,
                                                                                color: Colors.blue, // Color azul como un enlace
                                                                                decoration: TextDecoration.underline, // Subrayado
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    if (listViewIndex < listSolicitudes.length - 1)
                                                                      Divider(
                                                                        color: Colors.grey.withOpacity(0.2),
                                                                        thickness: 1,
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );

                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                  ],
                                ),
                              ),
                            )),
                      ])))),
    );
  }

  void _showFacturasBottomSheet(BuildContext context, List<factura> facturas) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: facturas.length,
            itemBuilder: (context, index) {
              var factura = facturas[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Factura ID
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Factura",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${factura.id}",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.grey[300]),
                        // Total Factura
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Factura:",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "\$${factura.totalFactura.toStringAsFixed(2)}",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.grey[300]),
                        // Comentarios (si existe)
                        if (factura.comentarios.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Comentarios:",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                "${factura.comentarios}",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[700],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Divider(color: Colors.grey[300]),
                            ],
                          ),
                        // Código
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Código:",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${factura.codigo}",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _openMapWithCoordinates(double lat, double lon) async {
    final Uri mapUri = Uri.parse("https://www.google.com/maps?q=$lat,$lon");
    if (await canLaunch(mapUri.toString())) {
      await launch(mapUri.toString());
    } else {
      throw 'Could not open map';
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Could not launch $phoneUri';
    }
  }
}
