import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:chat/global/environment.dart';

import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  //cuando una persona se concta a nuestra aplicion o cuando hacemos
  //una peticion al server recibimos informacion un objeto que nos
  //responde el backend. "usuario": online/nombre/email/uid
  //la idea es que este usuario tenga la info del usuario logeado!
  //mediante el AuthService

  // Usuario usuario;??
  Usuario usuario;

  //bloquear el boton de ingrese p/ k no se pueda hacer doble posteo
  bool _autenticando = false; //propiedad indica cuando se esta autenticando
  //como es privada entonces tengo que hacer con getters y setters;
  //y asi cuando se cambie la propiedad _autenticando a true o false,
  //=> notficara a los listeners es decir que cualquier persona o widget
  //que este escuchando los cambios de mi AuthService va a ser notificado
  //cuando cambie esa propiedad....este es uno de los usos de provider!!!!!
  //con guion bajo es privada solo aqui, y sin guion bajo aparce afuera!!!
  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners(); //notifica a todos los k estan escuchando _autenticando
    //para que se redibuje
  }

  //tengo que crear un metodo  future recibe email y password
  Future login(String email, String password) async {
    this.autenticando = true;

    //var url = Uri.parse('http://10.0.2.2:3000/api/login');
    var urlLogin = Uri.parse('${Environment.apiUrl}/login');

    //payload que mandare al backend
    final data = {'email': email, 'password': password};

    final resp = await http.post(urlLogin,
        body: jsonEncode(data), //convert la data(objeto) a su forma de json
        headers: {'Content-Type': 'application/json'});

    //necesitamos que esta repuesta, mapear a un tipo de modelo
    //propio de nuestra aplicacion! usamos https://quicktype.io
    print(resp.body);

    //necesito saber si la peticion se hace correctamente?
    //que statusCode me devuelve?400:; 401:;404:no se encontro
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

//      await this._guardarToken(loginResponse.token);
    }
//      return true;
//    } else {
//      return false;
//    }
    // hacemos lo inversa, ya sea que la info sea o no la correcta
    //ppero ya tenemos la informacion, => quitamos el loading!
    this.autenticando = false;
  }
}
