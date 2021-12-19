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

  //tengo que crear un metodo  future recibe email y password
  Future login(String email, String password) async {
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

      return true;
    } else {
      return false;
    }
  }
}
