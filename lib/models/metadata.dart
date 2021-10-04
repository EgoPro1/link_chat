// To parse this JSON data, do
//
//     final uservet = uservetFromJson(jsonString);

import 'dart:convert';

Metadata   metadaFromJson(String str) => Metadata.fromJson(json.decode(str));

String metadaToJson(Metadata  data) => json.encode(data.toJson());

class Metadata {
  Metadata (
      {
        this.gender,
        this.bloodType,
        this.skin
      });


  String ?gender;
  String ?bloodType = "O+";
  String ?skin;

  factory Metadata .fromJson(Map<String, dynamic> json) {
    return Metadata (

      gender: json["gender"],
      bloodType: json["bloodType"],
      skin: json["skin"],
    );
  }

  Map<String, dynamic> toJson() {
    return {

      "gender": gender,
      "bloodType": bloodType,
      "skin": skin,
    };
  }
}
