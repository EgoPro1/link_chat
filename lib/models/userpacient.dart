// To parse this JSON data, do
//
//     final uservet = uservetFromJson(jsonString);

import 'dart:convert';

import 'package:acceso_camara/models/metadata.dart';

UserPatient  userpatientFromJson(String str) => UserPatient.fromJson(json.decode(str));

String userpacientToJson(UserPatient  data) => json.encode(data.toJson());



/*
fullName,birthDate,email, bloodType,profession,studyCenter,address,gender,skin,speciality,cmp,password, rol

 */
class UserPatient {
  UserPatient (
      {
         this.fullName,
         this.birthDate,
         this.email,
         this.bloodType,
         this.profession,
         this.studyCenter,
         this.address,
         this.gender,
         this.skin,
         this.speciality,
         this.cmp,
         this.password,
         this.rol
       //  this.bloodType
      });



  String? fullName;
  String? birthDate;
  String? email;
  String? bloodType;
  String? profession;
  String? studyCenter;
  String? address;
  String? gender;
  String? skin;
  String? speciality;
  String? cmp;
  String? password;
  String? rol;

//  String ?bloodType = "O+";

  factory UserPatient .fromJson(Map<String, dynamic> json) {
    return UserPatient (
      //id: json["id"],
      fullName: json["fullName"],
      bloodType: json["bloodType"],
      birthDate: json["birthDate"],
      email: json["email"],
      password: json["password"],
      studyCenter: json["studyCenter"],
      profession: json["profession"],
      address: json["address"],
      gender: json["gender"],
      skin: json["skin"],
      speciality: json["speciality"],
      cmp: json["cmp"],
      rol: json["rol"],

 //     bloodType: json["bloodType"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "bloodType": bloodType,
      "birthDate": birthDate,
      "email": email,
      "password": password,
      "studyCenter": studyCenter,
      "profession": profession,
      "address":address,
      "gender": gender,
      "skin": skin,
      "speciality":speciality,
      "cmp": cmp,
      "rol": rol,


    //  "bloodType": bloodType,
    };
  }
}
