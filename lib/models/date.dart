// To parse this JSON data, do
//
//     final uservet = uservetFromJson(jsonString);

import 'dart:convert';

Date dateFromJson(String str) =>Date.fromJson(json.decode(str));

String dateToJson(Date data) => json.encode(data.toJson());

class Date {
  Date({

    this.seconds,
    this.nanoseconds,

  });


  int? seconds;
  int? nanoseconds;


  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(

      seconds: json["_seconds"],
      nanoseconds: json["_nanoseconds"],

    );
  }

  Map<String, dynamic> toJson() {
    return {

      "_seconds": seconds,
      "_nanoseconds": nanoseconds,

    };
  }
}
// To parse this JSON data, do
//
//     final uservet = uservetFromJson(jsonString);