import 'dart:convert';
import 'dart:io';
import 'package:acceso_camara/models/api_response.dart';
import 'package:acceso_camara/models/diagnosis_model.dart';
import 'package:acceso_camara/models/diagnosis_response.dart';
import 'package:acceso_camara/models/method_result_model.dart';
import 'package:acceso_camara/models/method_result_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MethodModelService with ChangeNotifier {
  static const API = 'https://melanomia.herokuapp.com/';
  Future<APIResponse<MethodResultResponse>> postModelResult(
      MethodResultModel item, String userId, String token) {
    return http
        .post(Uri.parse(API + 'result/$userId'),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              'Content-Type': 'application/json'
            },
            body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        print(data.body);
        return APIResponse<MethodResultResponse>(
            data: MethodResultResponse.fromJson(json.decode(data.body)));
      }
      return APIResponse<MethodResultResponse>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<MethodResultResponse>(
            error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<DiagnosisResponse>> postDiagnosis(
      DiagnosisModel diagnosis, String resultId, String expertId, String token) {
        
    return http
        .post(Uri.parse(API + 'result/diagnosis/$resultId/$expertId'),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              'Content-Type': 'application/json'
            },
            body: json.encode(diagnosis.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        print(data.body);
        return APIResponse<DiagnosisResponse>(
            data: DiagnosisResponse.fromJson(json.decode(data.body)));
      }
      return APIResponse<DiagnosisResponse>(
          error: true, errorMessage: 'An error occured');
    }).catchError((error) => APIResponse<DiagnosisResponse>(
            error: true, errorMessage: 'An error occured'));
  }
}
