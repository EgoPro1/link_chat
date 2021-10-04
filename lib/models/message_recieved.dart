// To parse this JSON data, do
//
//     final uservet = uservetFromJson(jsonString);

import 'dart:convert';

import 'package:acceso_camara/models/date.dart';

MessageR messagerloginFromJson(String str) =>MessageR.fromJson(json.decode(str));

String messagerToJson(MessageR data) => json.encode(data.toJson());

class MessageR {
  MessageR({

    this.message,
    this.idSender,
    this.rol,
    this.date,
  });


  String? message;
  String? idSender;
  String ?rol;
  Date ? date;

  factory MessageR.fromJson(Map<String, dynamic> json) {
    return MessageR(

      message: json["message"],
      idSender: json["idSender"],
      rol: json["rol"],
      date: Date.fromJson(json["date"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {

      "message": message,
      "idSender": idSender,
      "rol": rol,
      "date": date!.toJson(),

    };
  }
}
