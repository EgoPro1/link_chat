

import 'dart:convert';

Message messageloginFromJson(String str) =>Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({

    this.message,
    this.idSender,

  });


  String? message;
  String? idSender;


  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(

      message: json["message"],
      idSender: json["idSender"],

    );
  }

  Map<String, dynamic> toJson() {
    return {

      "message": message,
      "idSender": idSender,

    };
  }
}
