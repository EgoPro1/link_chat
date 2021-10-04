import 'dart:convert';
import 'dart:developer';

import 'package:acceso_camara/models/api_record_patient.dart';
import 'package:acceso_camara/models/api_response.dart';
import 'package:acceso_camara/models/history_item_response.dart';
import 'package:acceso_camara/models/patient_result_response.dart';
import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:acceso_camara/views/patient/result_patient_view.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RecordPatient extends StatefulWidget {
  RecordPatient({Key? key}) : super(key: key);

  @override
  _RecordPatientState createState() => _RecordPatientState();
}

class _RecordPatientState extends State<RecordPatient> {
  final _prefs = new PreferenciasUsuario();
  var resultid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text(
              "HISTORIAL",
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(color: const Color(0xFF1E4DE8)),
            child: Text(
              "Esperando",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(color: const Color(0xFF1E4DE8)),
            child: Text(
              "Historial Completo",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder(
              future: ApiRecordPatient()
                  .patientResultList(_prefs.getidpat, _prefs.gettoken),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var patientResultList =
                      (snapshot.data as APIResponse<List<HistoryItemResponse>>)
                          .data;

                  var parent = <Widget>[];
                  var row = Row(
                    children: [],
                  );
                  for (var i = 0; i < patientResultList!.length; i++) {
                    if (i != 0 && i % 2 == 0) {
                      parent.add(row);
                      row = Row(
                        children: [],
                      );
                    }
                    row.children.add(Expanded(
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResultPatientView(
                                      accuracy: patientResultList[i].modelPercentage!,
                                      label: patientResultList[i].modelResult!,
                                      imagePath: patientResultList[i].pictureUrl!,
                                      premium: patientResultList[i].isPremium!,
                                      diagnosisInfo: patientResultList[i].diagnosisData!,
                                      resultid:patientResultList[i].resultId!

                                    ))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.network(
                                patientResultList[i].pictureUrl!,
                                height: 80,
                                width: 80,
                                alignment: Alignment.center,
                                errorBuilder: (context, _, __) {
                                  return Image.asset(
                                    "assets/imagen3x.png",
                                    height: 80,
                                    width: 80,
                                    alignment: Alignment.center,
                                  );
                                },
                              ),
                              Container(
                                height: 200,
                                child: CircularPercentIndicator(
                                  circularStrokeCap: CircularStrokeCap.round,
                                  radius: 100.0,
                                  lineWidth: 15.0,
                                  center: new Text(
                                      (patientResultList[i].modelPercentage! *
                                                  100)
                                              .toStringAsFixed(2) +
                                          "%",
                                      style: const TextStyle(
                                        color: const Color(0xFF000000),
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  percent:
                                      patientResultList[i].modelPercentage!,
                                  progressColor:
                                      patientResultList[i].modelResult !=
                                              "melanoma"
                                          ? const Color(0xFF13AB46)
                                          : const Color(0xFFD50000),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
                  }
                  parent.add(row);

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: parent,
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text("ERROR"),
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ])));
  }
}
