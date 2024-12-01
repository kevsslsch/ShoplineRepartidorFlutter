import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'application/firebase_api.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'widgets/notification_page.dart';
import 'widgets/splash_screen.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final firebaseApi = FirebaseApi();
    await firebaseApi.initNotifications();
    await firebaseApi.configureBackgroundMessageHandler();

    runApp(MyApp());
  } catch (e) {
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Error al iniciar la aplicación: $e'),
        ),
      ),
    ));
    print('Error en main: $e');
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale("es", "PA");
  ThemeMode _themeMode = ThemeMode.light;
  bool displaySplashImage = true;

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() => _themeMode = mode);

  @override
  void initState() {
    super.initState();

    Future.delayed(
        Duration(seconds: 1), () => setState(() => displaySplashImage = false));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopline Repartidor',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('es', '')],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: FlutterFlowTheme.of(context).primaryColor, // Color primario de FlutterFlowTheme
          primary: FlutterFlowTheme.of(context).primaryColor,
          onPrimary: Colors.white,
          secondary: FlutterFlowTheme.of(context).secondaryColor, // Puedes definir un color secundario si lo necesitas
          surfaceTint: Colors.transparent,// Puedes definir un color secundario si lo necesitas
        ),
        appBarTheme: AppBarTheme(
          elevation: 4.0,
          shadowColor: Theme.of(context).colorScheme.shadow,
        ),
        // Define el color de los botones
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: FlutterFlowTheme.of(context).primaryColor, // Color del texto del botón
          ),
        ),
        // Define el tema de los diálogos
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: FlutterFlowTheme.of(context).primaryColor, // Color del título del diálogo
          ),
          contentTextStyle: TextStyle(
            color: Colors.black, // Color del contenido del diálogo
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Ajusta el borde del diálogo
          ),
        ),
        dividerTheme: DividerThemeData(
          color: Colors.grey[300], // Color de los divisores
          thickness: 1, // Grosor del divisor
        ),
      ),

      themeMode: _themeMode,
      home: SplashScreen(),
      navigatorKey: navigatorKey,
      routes: {
        '/notification_screen': (context) => NotificationPage(),
      },
    );
  }
}