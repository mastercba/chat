import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:chat/routes/routes.dart';
import 'package:chat/services/auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('entre al main de la APP!!!!!');
    return MultiProvider(
      //como el multiprovider esta aqui arriba del MaterialApp,
      //entonces todas las rutas van a tener en su context
      //mi AuthService
      providers: [
        //coleccion o listado de providers, aqui solo tengo uno
        //retorna(=>) la nueva instancia de nuestro AuthService
        //esto es todo para crear una instancia global de mi AuthService
        //que no solo me sirve para manejarlo como un singletone
        //sino que tb va a notificarle a los widgets necesarios cuando
        //yo quiera redibujarlos, y esa es la principal ventaja del provider
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: 'login',
        routes: appRoutes,
      ),
    );
  }
}
