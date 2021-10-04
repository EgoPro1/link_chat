

import 'dart:convert';

ResponseM responseMnFromJson(String str) =>ResponseM.fromJson(json.decode(str));

String messageToJson(ResponseM data) => json.encode(data.toJson());

class ResponseM {
  ResponseM({

    this.value,
    this.msg,
    this.code,

  });


  String? value;
  String? msg;
  String? code;

  factory ResponseM.fromJson(Map<String, dynamic> json) {
    return ResponseM(

      value: json["value"],
      msg: json["msg"],
      code: json["code"],

    );
  }

  Map<String, dynamic> toJson() {
    return {

      "value": value,
      "msg": msg,
      "code": code,

    };
  }
}
