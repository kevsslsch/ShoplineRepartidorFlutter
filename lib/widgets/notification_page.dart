import 'package:becadosCE/models/notificationModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

import '../application/functions.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class NotificationPage extends StatefulWidget {
  final notification? notificationItem;

  const NotificationPage({Key? key, this.notificationItem}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final htmlContent;
    String? title;

    if(widget.notificationItem == null){
      final message = ModalRoute.of(context)?.settings.arguments as RemoteMessage;
      final data = message.data; // Datos adicionales

      title = message.notification!.title.toString();
      htmlContent = data['html'];
    }else{
      title = widget.notificationItem?.titulo;
      htmlContent = widget.notificationItem?.html;
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).backgroundLogin,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios_new),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Text(
                  title!,
                  style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: FlutterFlowTheme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Expanded(
                child: SingleChildScrollView(
                  child: HtmlWidget(
                    htmlContent,
                    textStyle: GoogleFonts.getFont('Poppins'),
                  ),
                ),
              ),
              Align(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}