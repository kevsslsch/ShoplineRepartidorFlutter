
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../application/firebase_api.dart';
import '../application/functions.dart';
import '../backend/database_connect.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'main_widget.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late TextEditingController userController;
  late TextEditingController passwordController;

  late SharedPreferences preffs;
  String token = "";

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    passwordController = TextEditingController();
  }


  _login() async {
    preffs = await SharedPreferences.getInstance();

    String userValue = userController.text;
    String password = passwordController.text;

    await Firebase.initializeApp();
    token = (await FirebaseApi().getToken())!;

    if (userValue.isEmpty) {
      Functions.showAlert(context, "Debes escribir tu usuario");
    } else if (password.isEmpty) {
      Functions.showAlert(context, "Debes escribir tu contraseña");
    }else {
      DatabaseProvider.login(
          userValue, password, token)
          .then((value) {
        if (value.status) {
          preffs.setString("userValue", userValue);
          preffs.setString("password", password);

          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 300),
              reverseDuration: Duration(milliseconds: 300),
              child: MainWidget(usuario: value)
            ),
          );

        } else {
          Functions.showAlert(context, value.message);
        }
      });
    }
  }

  Future<void> _launchRecovery() async {
    final Uri _url = Uri.parse('https://shoplinepanama.com/casillero/recovery');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).backgroundLogin,
        appBar: AppBar(
          backgroundColor: Colors.white, // Status bar color
          elevation: 0, // Remove the gray border
        ),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsetsDirectional.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        // Path to your custom icon image
                        width: 200,
                        height: 100,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text("Inicia sesión",
                            style: GoogleFonts.getFont('Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Text(
                            "Ingresa tu usuario y contraseña.",
                            style: GoogleFonts.getFont('Poppins',
                                fontSize: 15, color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: TextFormField(
                          controller: userController,
                          decoration: InputDecoration(
                            labelText: 'Usuario administrativo',
                            labelStyle: GoogleFonts.getFont('Poppins',
                                fontSize: 14, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFF5F6FA),
                          ),
                          keyboardType: TextInputType.emailAddress, // Especifica el tipo de teclado para el correo electrónico
                          autofillHints: [AutofillHints.email], // Habilita el autollenado para el correo electrónico
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: GoogleFonts.getFont('Poppins',
                                fontSize: 14, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFF5F6FA),
                          ),
                          autofillHints: [AutofillHints.password], // Habilita el autollenado para la contraseña
                        ),
                      ),

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            _login();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                FlutterFlowTheme.of(context).primaryColor),
                            elevation: MaterialStateProperty.all(0),
                            // Eliminar la sombra
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.all(
                                  16.0), // Ajusta el padding según tus necesidades
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Iniciar sesión',
                              style: GoogleFonts.getFont('Poppins',
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: GestureDetector(
                              onTap: () {
                                Functions.launchWppPanamex();
                              },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Desarrollado por',
                                      style: TextStyle(fontSize: 15.0),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 10),
                                    Image.asset(
                                      'assets/images/logo_panamex.png',
                                      width: 140,
                                      height: 140,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]))));
  }
}
