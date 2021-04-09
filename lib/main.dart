import 'package:flutter/material.dart';
import 'package:freire/src/bloc/provider.dart';
import 'package:freire/src/pages/home_page.dart';
import 'package:freire/src/pages/login_page.dart';
import 'package:freire/src/pages/mensaje_page.dart';
import 'package:freire/src/pages/producto_page.dart';
import 'package:freire/src/pages/registro_page.dart';
import 'package:freire/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:freire/src/providers/push_notification_provider.dart';

void main() async {
  //Hay que agregar esto WidgetsFlutterBinding.ensureInitialized() para que las preferencias funcionen
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    final pushProvider = new PushNotificationsProvider();
    pushProvider.initNotifications();

    pushProvider.mensajesStream.listen((data) {
      // print('argumento desde main: $argumento');
      // Navigator.pushNamed(context, 'mensaje');
      navigatorKey.currentState.pushNamed('mensaje', arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    print(prefs.token);
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'registro': (BuildContext context) => RegistroPage(),
          'home': (BuildContext context) => HomePage(),
          'mensaje': (BuildContext context) => MensajePage(),
          'producto': (BuildContext context) => ProductoPage(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(13, 109, 153, 1),
        ),
      ),
    );
  }
}
