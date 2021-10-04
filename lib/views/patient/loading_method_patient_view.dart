import 'dart:io';
import 'dart:convert';
import 'package:acceso_camara/builder/tensorflow_service.dart';
import 'package:acceso_camara/constants/strings_resources.dart';
import 'package:acceso_camara/models/method_result_model.dart';
import 'package:acceso_camara/preferencias_usuario/prefs.dart';
import 'package:acceso_camara/services/file_service.dart';
import 'package:acceso_camara/services/method_model_service.dart';
import 'package:acceso_camara/views/patient/result_patient_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite/tflite.dart';

class LoadingMethodPatientView extends StatefulWidget {
  final int methodIndex;
  const LoadingMethodPatientView({Key? key, required this.methodIndex})
      : super(key: key);

  @override
  _LoadingMethodPatientViewState createState() =>
      _LoadingMethodPatientViewState();
}

class _LoadingMethodPatientViewState extends State<LoadingMethodPatientView> {
  late Future<dynamic> _runModel;
  FileService fileService= new FileService();
  var photos= <String>[];
  final _prefs = new PreferenciasUsuario();
  @override
  void initState() {
    _runModel = _loadAndRunModel();
    super.initState();
  }

  Future<dynamic> _loadAndRunModel() async {
    if (widget.methodIndex == 0) {
      await loadModel(
          "modelEfficientNetB0v2.tflite", "modelEfficientNetB0v2.txt");
    } else {
      await loadModel("modelMobileNetV2v2.tflite", "modelMobileNetV2v2.txt");
    }
    var preferences = await SharedPreferences.getInstance();
    var localImagePath = preferences.getString("temp_patient_image_path")!;
    var res = await Tflite.runModelOnImage(path: localImagePath);

    if (res == null || res.length <= 0) throw Exception("Sin resultados");
    // print(res);
    var net_img_url="";
    try {
      var _image=File(_prefs.getpath);
      var resp = await fileService.ImageUpload(_image,'skinPhoto');

      Map valueMap = json.decode(_prefs.getNpath);
      print(valueMap['url']);
      net_img_url=valueMap['url'];
      photos.add(net_img_url);
      _prefs.setpathl=photos;

      // print(response.toString());
      var bodyToPost = MethodResultModel(
          pictureUrl: net_img_url /*imagePath */,
          modelResult: res[0]["label"],
          modelPercentage: res[0]["confidence"].toString(),
          modelArchitecture: widget.methodIndex == 0
              ? "efficientNetB0"
              : widget.methodIndex == 1
                  ? "mobileNetV2"
                  : "");
      var methodService = MethodModelService();
      // print(bodyToPost.toJson());
      var response = await methodService.postModelResult(
          bodyToPost,
          _prefs.getidpat,
          _prefs.gettoken);


    } catch (e) {
      print(e);
    }
    res[0]["image_path"] = net_img_url;
    preferences.remove("temp_patient_image_path"); //Se libera
    
    return res[0];
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E4DE8),
      body: FutureBuilder(
          future: _runModel,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              SchedulerBinding.instance!.addPostFrameCallback((_) {
                Navigator.of(context).pop();
              });
            }

            if (snapshot.hasData) {
              final result = (snapshot.data as dynamic);
              SchedulerBinding.instance!.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ResultPatientView(
                          accuracy: result["confidence"],
                          label: result["label"],
                          imagePath: result["image_path"],
                          premium: false,
                          diagnosisInfo: List.empty(),
                          resultid:result["resultId"],
                        )));
              });
            }

            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.methodIndex == 0
                        ? "Método 1"
                        : widget.methodIndex == 1
                            ? "Método 2"
                            : "",
                    style: const TextStyle(
                        fontSize: 24.0,
                        color: const Color(0xFF949FFF),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "ANALIZANDO",
                    style: const TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: SizedBox(
                        width: 100.0,
                        height: 100.0,
                        child: CircularProgressIndicator(
                          backgroundColor: const Color(0xFF949FFF),
                          color: Colors.white,
                          strokeWidth: 12.0,
                        )),
                  ),
                  Text(
                    StringsResources.LOADING_DESCRIPTION,
                    style: const TextStyle(fontSize: 10.0),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
