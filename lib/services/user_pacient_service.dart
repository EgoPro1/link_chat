import 'dart:convert';
import 'dart:io';

import 'package:acceso_camara/models/api_response.dart';
import 'package:acceso_camara/models/login_response.dart';
import 'package:acceso_camara/models/user.dart';
import 'package:acceso_camara/models/userpacient.dart';
import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class LoginService with ChangeNotifier {
  // final String _firebaseToken = 'AIzaSyAzIGZax6Pn30zGytZkwyXJdEmsKiRDRc8';
  static const API = 'http://192.168.0.2:3006/';
 /* static const headers = {
    // 'apiKey': '08d771e2-7c49-1789-0eaa-32aff09f1471',
    'Content-Type': 'application/json'
  };*/

  //final _prefs = new PreferenciasUsuario();
  Future<APIResponse<bool>> nuevoUsuario(UserPatient item,String id,String token) {

    //   final urlPetcare = _prefs.urlPetcare;
    return http
        .post(Uri.parse(API +'patient/${id}'),
            headers:{
               HttpHeaders.authorizationHeader: 'Bearer $token',
              'Content-Type': 'application/json'
            }, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        print(data.body);
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}
