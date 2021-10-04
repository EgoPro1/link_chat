// To parse this JSON data, do
//
//     final uservet = uservetFromJson(jsonString);

import 'dart:convert';

Userlogin userloginFromJson(String str) => Userlogin.fromJson(json.decode(str));

String userToJson(Userlogin data) => json.encode(data.toJson());

class Userlogin {
  Userlogin({
 //   this.id,
    this.email,
 //   this.tipoDoc,
   // this.nroDoc,
    this.password,

  });
/*



 */
 // int? id = 0;

  String? email;
 // String? tipoDoc;
 // String? nroDoc;
  String? password;


  factory Userlogin.fromJson(Map<String, dynamic> json) {
    return Userlogin(
   //   id: json["id"],
      email: json["email"],
  //    tipoDoc: json["tipoDoc"],
  //    nroDoc: json["nroDoc"],
      password: json["password"],

    );
  }

  Map<String, dynamic> toJson() {
    return {
    //  "id": id,
      "email": email,
    //   "tipoDoc":tipoDoc,
    //  "nroDoc":nroDoc,
      "password": password,

    };
  }
}
