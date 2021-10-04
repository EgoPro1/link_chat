import 'dart:convert';
import 'dart:io';

import 'package:acceso_camara/models/api_response.dart';
import 'package:acceso_camara/models/patient_result_response.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class PremiumService with ChangeNotifier {
  Future<APIResponse<List<PatientResultResponse>>> premiumList(String token) async {
    String url = "https://melanomia.herokuapp.com/";
    return http.get(
      Uri.parse(url + 'result/getallpremium'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((data) {
      if (data.statusCode == 200) {
        // print(data.body);
        var premiumList =
            (json.decode(data.body) as Map<String, dynamic>)["response"];
        return APIResponse<List<PatientResultResponse>>(
            data: premiumList
                .map<PatientResultResponse>(
                    (item) => PatientResultResponse.fromJson(item))
                .toList());
      }
      return APIResponse<List<PatientResultResponse>>(
          error: null, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<PatientResultResponse>>(
        error: true, errorMessage: 'An error occured'));
  }
}
