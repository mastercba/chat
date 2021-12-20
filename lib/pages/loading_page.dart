import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';

import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/usuarios_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        //llamamos al Future y le mando el context para hacer la navegacion
        future: checkLoginState(context),
        builder: (context, snapshot) {
          //
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  // Hacemos la verificacion
  // el BuildContext context lo uso porque necesito mover la pantalla
  Future checkLoginState(BuildContext context) async {
    //instancia del provider para leer mi AuthService
    //listen:false   No necesito que esto se redibuje!
    final authService = Provider.of<AuthService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      // TODO: conectar al socket server
      // Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => UsuariosPage(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginPage(),
              transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
