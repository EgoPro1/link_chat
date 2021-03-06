import 'dart:convert';
import 'dart:io';

import 'package:acceso_camara/chat/chat.dart';
import 'package:acceso_camara/constants/strings_resources.dart';
import 'package:acceso_camara/models/api_response.dart';
import 'package:acceso_camara/models/history_item_response.dart';
import 'package:acceso_camara/models/patient_result_response.dart';
import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;

class ApiRequestExpert with ChangeNotifier {
  Future<APIResponse<List<PatientResultResponse>>> requestExpertList(
      String resultId, String token) async {
    String url = "https://melanomia.herokuapp.com/";
    return http.put(
      Uri.parse(url + 'result/isPremium/$resultId'),
      body: json.encode({'isPremium': true}),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((data) {
      if (data.statusCode == 200) {
        var requestExpertList =
            (json.decode(data.body) as Map<String, dynamic>)["response"];
        return APIResponse<List<PatientResultResponse>>(
            data: requestExpertList
                .map<PatientResultResponse>(
                    (item) => PatientResultResponse.fromJson(item))
                .toList());
      }
      return APIResponse<List<PatientResultResponse>>(
          error: null, errorMessage: 'An error occured');
    }).catchError((error) => APIResponse<List<PatientResultResponse>>(
        error: true, errorMessage: 'An error occured'));
  }
}

class ResultPatientView extends StatefulWidget {
  final double accuracy;
  final String label;
  final String imagePath;
  final bool premium;
  final List diagnosisInfo;
  final String resultid;
  //final String name;

  const ResultPatientView({
    Key? key,
    required this.accuracy,
    required this.label,
    required this.imagePath,
    required this.premium,
    required this.diagnosisInfo,
    required this.resultid,
    //required this.name
  }) : super(key: key);

  @override
  _ResultPatientViewState createState() => _ResultPatientViewState();
}

class _ResultPatientViewState extends State<ResultPatientView> {
  @override
  Widget build(BuildContext context) {
    String expertlabel = "";
    String expertdescription = "";
    String expertName = "";

    if (widget.diagnosisInfo.length == 0) {
    } else {
      expertlabel = widget.diagnosisInfo[0].result;
      expertdescription = widget.diagnosisInfo[0].description;
      expertName = widget.diagnosisInfo[0].expertName;
    }

    bool expertRequested = this.widget.premium;
    var preferences = PreferenciasUsuario();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E4DE8),
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(color: const Color(0xFF1E4DE8)),
              child: Text(
                "RESULTADOS",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          this.widget.imagePath,
                          height: 200,
                          alignment: Alignment.center,
                          errorBuilder: (context, _, __) {
                            return Image.asset(
                              "assets/imagen3x.png",
                              height: 200,
                              alignment: Alignment.center,
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          alignment: Alignment.center,
                          color: this.widget.label != "melanoma"
                              ? const Color(0xFF85F28C)
                              : const Color(0xFFFF988A),
                          child: CircularPercentIndicator(
                            circularStrokeCap: CircularStrokeCap.round,
                            radius: 120.0,
                            lineWidth: 15.0,
                            center: new Text(
                                (this.widget.accuracy * 100)
                                        .toStringAsFixed(2) +
                                    "%",
                                style: TextStyle(
                                  color: this.widget.label != "melanoma"
                                      ? const Color(0xFF13AB46)
                                      : const Color(0xFFDC3131),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                )),
                            percent: this.widget.accuracy,
                            progressColor: this.widget.label != "melanoma"
                                ? const Color(0xFF13AB46)
                                : const Color(0xFFDC3131),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.check,
                  color: this.widget.label != "melanoma"
                      ? const Color(0xFF13AB46)
                      : const Color(0xFFDC3131),
                  size: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Es " + this.widget.label,
                    style: TextStyle(
                        color: this.widget.label != "melanoma"
                            ? const Color(0xFF13AB46)
                            : const Color(0xFFDC3131),
                        fontSize: 20.0),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: this.widget.accuracy >= 0.99
                  ? Text(
                      StringsResources.RESULT_PATIENT_DESCRIPTION1,
                      style: TextStyle(color: Colors.black),
                    )
                  : Text(
                      StringsResources.RESULT_PATIENT_DESCRIPTION2,
                      style: TextStyle(color: Colors.black),
                    ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: const Color(0xFF1E4DE8)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Premium",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(Icons.star, color: Colors.white)
                  ],
                ),
              ),
            ),
            StatefulBuilder(builder: (builder, setState) {
              if (expertRequested && widget.diagnosisInfo.isNotEmpty) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: const Color(0xFFEFEFEF)),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 2,
                                      color: const Color(0xFF13AB46))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.check,
                                  color: const Color(0xFF13AB46),
                                  size: 32.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: new TextSpan(
                                style: new TextStyle(
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  new TextSpan(
                                      text: expertlabel,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  new TextSpan(text: " " + expertdescription),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFF1E4DE8),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 2,
                                      color: const Color(0xFF1E4DE8))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 32.0,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  expertName,
                                  style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      color: const Color(0xFF1E4DE8)),
                                ),
                                Text(
                                  "Experto",
                                  style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12.0,
                                      color: const Color(0xFF434343)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            setState(() => expertRequested = true);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  diagnosisInfo: widget.diagnosisInfo[0],
                                  premium: widget.premium,
                                  resultid: widget.resultid,
                                  expertName: expertName,
                                  //name: '',
                                ),
                              ),
                            );
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF1E4DE8))),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              "CHAT",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    )
                  ],
                );
              }

              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "??Te gustar??a tener un an??lisis m??s completo? Solicita la opini??n de un experto para que analice tu caso y resuelva todas tus dudas.",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: TextButton(
                          onPressed: expertRequested
                              ? null
                              : () {
                                  setState(() {
                                    expertRequested = true;
                                    ApiRequestExpert().requestExpertList(
                                        widget.resultid, preferences.gettoken);
                                  });
                                },
                          style: expertRequested == true
                              ? ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF949FFF)))
                              : ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFF1E4DE8))),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: expertRequested == true
                                ? Text(
                                    "EXPERTO SOLICITADO",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(
                                    "SOLICITAR EXPERTO",
                                    style: TextStyle(color: Colors.white),
                                  ),
                          )),
                    )
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
