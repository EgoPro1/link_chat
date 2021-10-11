import 'dart:convert';

import 'package:acceso_camara/models/api_response.dart';
import 'package:acceso_camara/models/login_response.dart';
import 'package:acceso_camara/models/user.dart';
import 'package:acceso_camara/models/userpacient.dart';
import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class UserService with ChangeNotifier {

  // final String _firebaseToken = 'AIzaSyAzIGZax6Pn30zGytZkwyXJdEmsKiRDRc8';
  static const API = 'http://192.168.0.2:3006/signup';
  static const headers = {
    // 'apiKey': '08d771e2-7c49-1789-0eaa-32aff09f1471',
    'Content-Type': 'application/json'
  };
  final _prefs = new PreferenciasUsuario();

  Future<APIResponse<String>> createUser(UserPatient item) {

    final url = _prefs.geturl;
    return http
        .post(Uri.parse(url + 'signup'),
        headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        print("FUNCIONA");
        print(data.body);

        return APIResponse<String>(data: data.body);
      }
      return APIResponse<String>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<String>(error: true, errorMessage: 'An error occured'));
  }


  Future<APIResponse<LoginResponse>> login(String uID, String uPwd) {
    final url = _prefs.geturl;
    Userlogin log=new Userlogin();
    log.email=uID;
    log.password=uPwd;
    _prefs.setemail=uID;
    _prefs.setpass=uPwd;

    return http
        .post(Uri.parse(url + 'signin'),
        headers: headers, body: json.encode(log.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        final jsonData = json.decode(data.body);
        if (jsonData['rol'] != 'patient'&&jsonData['rol'] != 'expert') {
          return APIResponse<LoginResponse>(
              error: true, errorMessage: 'No existe el usuario');
        }
        _prefs.settoken = jsonData['token'];
        _prefs.setrol = jsonData['rol'];
        _prefs.setname=jsonData['fullName'];


        if(_prefs.getrol=='patient') {
          _prefs.setidpat=jsonData['id'];

        }else{
          _prefs.setidexp=jsonData['id'];
        }
        _prefs.setrolid=jsonData['rolId'];

        return APIResponse<LoginResponse>(
            data: LoginResponse.fromJson(jsonData));
      }
      return APIResponse<LoginResponse>(
          error: true, errorMessage: 'El usuario y/o Contraseña es incorrecto');
    }).catchError((_) => APIResponse<LoginResponse>(
        error: true, errorMessage: 'An error occured'));
  }
}