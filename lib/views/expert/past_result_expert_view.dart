import 'package:acceso_camara/chat/chat.dart';
import 'package:acceso_camara/constants/strings_resources.dart';
import 'package:acceso_camara/models/diagnosis_model.dart';
import 'package:acceso_camara/models/history_item_response.dart';
import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:acceso_camara/services/method_model_service.dart';
import 'package:acceso_camara/widgets/dropdown_list.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PastResultExpertView extends StatelessWidget {
  final String resultId;
  final double accuracy;
  final String label;
  final String imagePath;
  final DiagnosisModel diagnosis;

  const PastResultExpertView(
      {Key? key,
      required this.resultId,
      required this.accuracy,
      required this.label,
      required this.imagePath,
      required this.diagnosis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool diagnosticarCasoButtonPressed = false;
    TextEditingController textAreaController =
        new TextEditingController(text: diagnosis.description);
    var selectedDrodownlistValue = diagnosis.result;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF13AB46),
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
              decoration: BoxDecoration(color: const Color(0xFF13AB46)),
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
                          this.imagePath,
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
                          color: this.label != "melanoma"
                              ? const Color(0xFF85F28C)
                              : const Color(0xFFFF988A),
                          child: CircularPercentIndicator(
                            circularStrokeCap: CircularStrokeCap.round,
                            radius: 120.0,
                            lineWidth: 15.0,
                            center: new Text(
                                (this.accuracy * 100).toStringAsFixed(2) + "%",
                                style: TextStyle(
                                  color: this.label != "melanoma"
                                      ? const Color(0xFF13AB46)
                                      : const Color(0xFFDC3131),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                )),
                            percent: this.accuracy,
                            progressColor: this.label != "melanoma"
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
                  color: this.label != "melanoma"
                      ? const Color(0xFF13AB46)
                      : const Color(0xFFDC3131),
                  size: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Es " + this.label,
                    style: TextStyle(
                        color: this.label != "melanoma"
                            ? const Color(0xFF13AB46)
                            : const Color(0xFFDC3131),
                        fontSize: 20.0),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: this.accuracy >= 0.99
                  ? Text(
                      StringsResources.RESULT_EXPERT_DESCRIPTION1,
                      style: TextStyle(color: Colors.black),
                    )
                  : Text(
                      StringsResources.RESULT_EXPERT_DESCRIPTION2,
                      style: TextStyle(color: Colors.black),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StatefulBuilder(builder: (context, setState) {
                return AppDropdownInput(
                  hintText: "Seleccione",
                  options: ['benign keratosis', 'melanoma', 'nevus', 'unknown'],
                  getLabel: (String value) => value,
                  value: selectedDrodownlistValue,
                  onChanged: (String? value) => setState(() {
                    selectedDrodownlistValue = value!;
                  }),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: const Color(0xFFEFEFEF),
                child: TextField(
                  controller: textAreaController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            StatefulBuilder(builder: (context, setState) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                width: double.infinity,
                child: TextButton(
                    onPressed: diagnosticarCasoButtonPressed
                        ? null
                        : () {
                            setState(() {
                              diagnosticarCasoButtonPressed = true;
                              var _prefs = PreferenciasUsuario();
                              MethodModelService().putDiagnosis(
                                  DiagnosisModel.fromJson({
                                    "result": selectedDrodownlistValue,
                                    "description": textAreaController.text
                                  }),
                                  this.resultId,
                                  _prefs.getidexp,
                                  _prefs.gettoken);
                            });
                          },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            diagnosticarCasoButtonPressed
                                ? Colors.grey.shade300
                                : const Color(0xFF13AB46))),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        "ACTUALIZAR CASO",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    )),
              );
            }),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: TextButton(
                  onPressed: () {
                    DiagnosisData diagnosisInfo = new DiagnosisData();
                    var list = <DiagnosisData>[];
                    list.add(diagnosisInfo);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        diagnosisInfo: diagnosisInfo,
                        premium: true,
                        resultid: resultId,
                        expertName: 'Paciente',
                      ),
                    ));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          diagnosticarCasoButtonPressed
                              ? Colors.grey.shade300
                              : const Color(0xFF13AB46))),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "CHAT",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
