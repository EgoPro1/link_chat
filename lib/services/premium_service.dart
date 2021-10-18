import 'dart:convert';
import 'dart:io';

import 'package:acceso_camara/models/api_response.dart';
import 'package:acceso_camara/models/diagnosis_model.dart';
import 'package:acceso_camara/models/patient_result_response.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class PremiumService with ChangeNotifier {
  Future<APIResponse<List<PatientResultResponse>>> diagnosisCases(
      String token) async {
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
        var diagnosisCases =
            (json.decode(data.body) as Map<String, dynamic>)["response"];
        return APIResponse<List<PatientResultResponse>>(
            data: diagnosisCases
                .map<PatientResultResponse>(
                    (item) => PatientResultResponse.fromJson(item))
                .toList());
      }
      return APIResponse<List<PatientResultResponse>>(
          error: null, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<PatientResultResponse>>(
        error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<List<PatientResultResponse>>> diagnosedCases(
      String expertId, String token) async {
    String url = "https://melanomia.herokuapp.com/";

    var response = await http.get(
      Uri.parse(url + 'result/diagnosis-expert/$expertId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode != 200) throw Exception("Ocurrió un problema");

    var diagnosedCasesList =
        (json.decode(response.body) as Map<String, dynamic>)["response"];
    return APIResponse<List<PatientResultResponse>>(
        data: diagnosedCasesList.map<PatientResultResponse>((item) {
      var diagnosisList = item["diagnosisData"] as List<dynamic>;
      return PatientResultResponse(
          resultId: item["resultId"],
          modelResult: item["resultData"]["modelResult"],
          modelPercentage: double.tryParse(
              item["resultData"]["modelPercentage"] == "string"
                  ? "0"
                  : item["resultData"]["modelPercentage"] ?? "0"),
          pictureUrl: item["resultData"]["pictureUrl"],
          diagnosis: DiagnosisModel(
              result:
                  diagnosisList.length <= 0 ? "" : diagnosisList[0]["result"],
              description: diagnosisList.length <= 0
                  ? ""
                  : diagnosisList[0]["description"]));
    }).toList());
  }
}
