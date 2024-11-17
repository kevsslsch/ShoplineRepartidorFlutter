import 'dart:io';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:becadosCE/widgets/login_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../application/firebase_api.dart';
import '../application/functions.dart';
import '../backend/database_connect.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'main_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0;

  late SharedPreferences preffs;
  String token = "";

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  _getVersion() async {
    try {
      var value = await DatabaseProvider.getVersion();
      int last_version_server = int.parse(value.last_min_version.replaceAll(".", ""));
      int current_version_software = int.parse(DatabaseProvider.VERSION.toString().replaceAll(".", ""));
      if (last_version_server > current_version_software) {
        if (Platform.isIOS) {
          _errorVersion("Tienes una versión desactualizada, la mínima es: ${value.last_min_version}", value.url_ios);
        } else {
          _errorVersion("Tienes una versión desactualizada, la mínima es: ${value.last_min_version}", value.url_android);
        }
      } else {
        print("ESTÁS EN UNA VERSIÓN MAYOR O IGUAL A LA MÍNIMA");
        _currentSession();
      }
    } catch (e) {
      Functions.showAlert(context, 'Error en _getVersion: $e');
      print('Error en _getVersion: $e');
    }
  }

  void _errorVersion(String error, String url) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text('Es necesario actualizar este dispositivo'),
            content: Text(
              error.isNotEmpty ? error : "Error inesperado, contacte a Panamex Software",
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  final Uri _url = Uri.parse(url);
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: Text('Actualizar'),
              ),
            ],
          ),
        );
      },
    );
  }

  _currentSession() async {
    try {
      preffs = await SharedPreferences.getInstance();
      String? userValue = preffs.getString("userValue");
      String? password = preffs.getString("password");
      token = (await FirebaseApi().getToken())!;

      if (userValue != null && password != null) {
        Future.delayed(Duration(seconds: 1)).then((value) {
          DatabaseProvider.login(userValue!, password!, token).then((value) {
            if (value.status) {
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
              Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 300),
                    reverseDuration: Duration(milliseconds: 300),
                    child: LoginWidget()
                ),
              );
            }
          }).catchError((e) {
            Functions.showAlert(context, 'Error en DatabaseProvider.login: $e');
          });
        });
      } else {
        Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 300),
              reverseDuration: Duration(milliseconds: 300),
              child: LoginWidget()
          ),
        );
      }
    } catch (e) {
      Functions.showAlert(context, 'Error en _currentSession: $e');
      print('Error en _currentSession: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      childWidget: SizedBox(
        height: 350,
        width: 350,
        child: Image.asset("assets/images/logo.png"),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      asyncNavigationCallback: () async {
        print("object1");
        await Future.delayed(const Duration(milliseconds: 3000));
        print("object2");
      },
    );
  }
}