import 'dart:convert';
import 'dart:io';

import 'package:acceso_camara/models/api_response.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import 'history_item_response.dart';

class ApiRecordPatient with ChangeNotifier {
  Future<APIResponse<List<HistoryItemResponse>>> patientResultList(
      String userId, String token) async {
    String url = "https://melanomia.herokuapp.com/";
    return http.get(
      Uri.parse(url + 'result-userId/$userId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((data) {
      if (data.statusCode == 200) {
        // print(data.body);
        var patientResultList =
            (json.decode(data.body) as Map<String, dynamic>)["response"];
        return APIResponse<List<HistoryItemResponse>>(
            data: patientResultList
                .map<HistoryItemResponse>(
                    (item) => HistoryItemResponse.fromJson(item))
                .toList());
      }
      return APIResponse<List<HistoryItemResponse>>(
          error: null, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<HistoryItemResponse>>(
        error: true, errorMessage: 'An error occured'));
  }
}
