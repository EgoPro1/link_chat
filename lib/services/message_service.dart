import 'dart:convert';

import 'package:acceso_camara/models/api_response.dart';
import 'package:acceso_camara/models/history_item_response.dart';
import 'package:acceso_camara/models/login_response.dart';
import 'package:acceso_camara/models/message.dart';
import 'package:acceso_camara/models/message_recieved.dart';
import 'package:acceso_camara/models/user.dart';
import 'package:acceso_camara/models/userpacient.dart';
import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class MessageService with ChangeNotifier {

  // final String _firebaseToken = 'AIzaSyAzIGZax6Pn30zGytZkwyXJdEmsKiRDRc8';
  static const API = 'http://192.168.0.2:3006/signup';
  static const headers = {
    // 'apiKey': '08d771e2-7c49-1789-0eaa-32aff09f1471',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhbGdvcml0aG0iOiJSUzI1NiIsImV4cGlyZXNJbiI6IjYwZCIsImVtYWlsIjoiYWJyYXpvQGdtYWlsLmNvbSIsImZ1bGxOYW1lIjoia2RrZmtma2tma2dnIiwicm9sIjoiZXhwZXJ0IiwiaWQiOiI2NmNiMzYzYy02NjgwLTQ3NWEtOWE0Mi1lNTYxOWU1ZmQ2ODkiLCJyb2xJZCI6ImM5YTAxODE3LWE2MjItNGM4OC05YjlkLWM4Y2NmYmU1OGUzYSIsImlhdCI6MTYzMjUxMzE5Mn0.WtRwm1qkcgNquBTwPSr7cURgMacbalLicY9riud-qxU'
   /* 'Authorization': 'Bearer ${"token"}'*/
  };

  final _prefs = new PreferenciasUsuario();

  Future<APIResponse<String>> createMessage(String mensaje,DiagnosisData  diagnosisInfo,String resultid) {
    Message msg = new Message();
    msg.message = mensaje;
    //msg.idSender = "83c70a45-2220-472e-a855-16c795a87d72";
    if(_prefs.getrol=='patient')
     msg.idSender = _prefs.getidpat;
    else
      msg.idSender = _prefs.getidexp;
    final url = _prefs.geturl;
    print(resultid);
    print(diagnosisInfo.expertId);
    if(_prefs.getrol=='expert')
      diagnosisInfo.expertId=_prefs.getidexp;

    return http
        .post(Uri.parse(url +
        'result/messages/${resultid}/${diagnosisInfo.expertId}'),
        headers: headers, body: json.encode(msg.toJson()))
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

  Future<APIResponse<List<MessageR>>> getMessagesList(DiagnosisData  diagnosisInfo,String resultid) {
    MessageR msg = new MessageR();

    if(_prefs.getrol=='expert') diagnosisInfo.expertId=_prefs.getidexp;

    //msg.idSender = "83c70a45-2220-472e-a855-16c795a87d72";

    final url = _prefs.geturl;
    if(_prefs.getrol=='expert')
      diagnosisInfo.expertId=_prefs.getidexp;
    return http.get(Uri.parse(url +
        'result/messages/${resultid}/${diagnosisInfo.expertId}'), headers: headers).then((data) {
      if (data.statusCode == 201||data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        final mensajes_recibidos= <MessageR>[];


        for (var item in jsonData["response"]) {

          mensajes_recibidos.add(MessageR.fromJson(item));
        }
        return APIResponse<List<MessageR>>(data: mensajes_recibidos);
      }
      return APIResponse<List<MessageR>>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<List<MessageR>>(error: true, errorMessage: 'An error occured'));
  }



}